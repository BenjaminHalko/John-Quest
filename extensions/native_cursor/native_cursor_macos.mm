// native_cursor_macos.mm
// macOS implementation of native_cursor extension for GameMaker
// Compile: clang++ -arch x86_64 -arch arm64 -std=c++17 -ObjC++ -fno-objc-arc
//          -dynamiclib -fvisibility=default -O2
//          -framework AppKit -framework CoreGraphics -framework Foundation
//          -mmacosx-version-min=10.13 -o libnative_cursor.dylib native_cursor_macos.mm

#include <cstdint>
#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <sys/stat.h>

#import <AppKit/AppKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>

using namespace std;

#define dllg /* tag */
#define dllx extern "C" __attribute__((visibility("default")))

#define trace(...) { printf("[native_cursor:%d] ", __LINE__); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }

// ==================== Memory helpers ====================

template<typename T> T* malloc_arr(size_t count) {
	return (T*)malloc(sizeof(T) * count);
}
template<typename T> T* realloc_arr(T* arr, size_t count) {
	return (T*)realloc(arr, sizeof(T) * count);
}

// ==================== GML extension types ====================

template <typename T> using gml_ptr = T*;
template <typename T> using gml_ptr_destroy = T*;

struct gml_buffer {
private:
	uint8_t* _data;
	int32_t _size;
	int32_t _tell;
public:
	gml_buffer() : _data(nullptr), _tell(0), _size(0) {}
	gml_buffer(uint8_t* data, int32_t size, int32_t tell) : _data(data), _size(size), _tell(tell) {}
	inline uint8_t* data() { return _data; }
	inline int32_t tell() { return _tell; }
	inline int32_t size() { return _size; }
};

class gml_istream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_istream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> T read() {
		T result{};
		std::memcpy(&result, pos, sizeof(T));
		pos += sizeof(T);
		return result;
	}

	char* read_string() {
		char* r = (char*)pos;
		while (*pos != 0) pos++;
		pos++;
		return r;
	}

	gml_buffer read_gml_buffer() {
		auto _data = (uint8_t*)read<int64_t>();
		auto _size = read<int32_t>();
		auto _tell = read<int32_t>();
		return gml_buffer(_data, _size, _tell);
	}
};

class gml_ostream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_ostream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> void write(T val) {
		memcpy(pos, &val, sizeof(T));
		pos += sizeof(T);
	}

	void write_string(const char* s) {
		for (int i = 0; s[i] != 0; i++) write<char>(s[i]);
		write<char>(0);
	}
};

// ==================== native_cursor struct ====================

struct native_cursor {
	int count;
	int currentFrame;
	double framerate;
	NSCursor** cursors;

	inline void init(int _count) {
		count = _count;
		currentFrame = 0;
		framerate = 30;
		if (_count > 0) {
			cursors = (NSCursor**)calloc(_count, sizeof(NSCursor*));
		} else {
			cursors = NULL;
		}
	}

	inline void setFramerate(double fps) {
		framerate = fps;
	}

	inline int addFrames(int _count) {
		int start = count;
		int newcount = start + _count;
		count = newcount;
		cursors = (NSCursor**)realloc(cursors, newcount * sizeof(NSCursor*));
		for (int i = start; i < newcount; i++) {
			cursors[i] = nil;
		}
		return start;
	}

	inline void clear() {
		cursors = NULL;
	}

	inline int getCurrentFrame() {
		if (count == 0) return -1;
		int f = currentFrame;
		if (f < 0 || f >= count) f = 0;
		return f;
	}

	inline NSCursor* getCurrentCursor() {
		int fi = getCurrentFrame();
		if (fi < 0) return nil;
		return cursors[fi];
	}

	inline void free_resources() {
		if (cursors) {
			for (int i = 0; i < count; i++) {
				if (cursors[i]) [cursors[i] release];
			}
			::free(cursors);
		}
		clear();
	}
};

// ==================== Global state ====================

static NSWindow* game_window = nil;
static bool cursor_rects_disabled = false;
static bool nc_cursor_hidden = false;

static struct {
	native_cursor* cursor;
	NSCursor* activeCursor;
	inline void init() {
		cursor = nullptr;
		activeCursor = nil;
	}
} current;

// Timer that re-applies our cursor automatically — the macOS equivalent of
// the Windows WM_SETCURSOR hook. Doesn't matter how GameMaker resets the
// cursor, we override it on the next tick. Runs only while a custom cursor
// is active. No GML per-frame call needed.

@interface NCTimerTarget : NSObject
+ (void)tick:(NSTimer*)timer;
@end

@implementation NCTimerTarget
+ (void)tick:(NSTimer*)timer {
	if (current.cursor && current.cursor->count > 0) {
		// Only re-apply when the mouse is inside the game window
		NSWindow* win = [NSApp keyWindow];
		if (win) {
			NSPoint mouseScreen = [NSEvent mouseLocation];
			NSRect frame = [win contentRectForFrameRect:[win frame]];
			if (NSMouseInRect(mouseScreen, frame, NO)) {
				NSCursor* hc = current.cursor->getCurrentCursor();
				if (hc) [hc set];
			}
		}
	}
}
@end

static NSTimer* nc_timer = nil;

static void nc_start_timer() {
	if (!nc_timer) {
		nc_timer = [NSTimer timerWithTimeInterval:1.0/120.0
			target:[NCTimerTarget class]
			selector:@selector(tick:)
			userInfo:nil
			repeats:YES];
		[nc_timer retain];
		// Add to common modes so it fires during event tracking, modal panels, etc.
		[[NSRunLoop mainRunLoop] addTimer:nc_timer forMode:NSRunLoopCommonModes];
	}
}

static void nc_stop_timer() {
	if (nc_timer) {
		[nc_timer invalidate];
		[nc_timer release];
		nc_timer = nil;
	}
}

static bool SwapRedBlue_needed;

static void SwapRedBlue(uint8_t* buf, size_t count) {
	if (!SwapRedBlue_needed) return;
	for (size_t i = 0; i < count; i += 4) {
		uint8_t tmp = buf[i];
		buf[i] = buf[i + 2];
		buf[i + 2] = tmp;
	}
}

// ==================== Cursor creation helpers ====================

static void pixelDataReleaseCallback(void* info, const void* data, size_t size) {
	free((void*)data);
}

static NSCursor* CreateCursorFromPixels(uint8_t* srcPixels, int width, int height, int hotspot_x, int hotspot_y) {
	size_t dataSize = (size_t)width * height * 4;

	// Copy pixel data + apply R/B swap if needed
	uint8_t* pixels = (uint8_t*)malloc(dataSize);
	memcpy(pixels, srcPixels, dataSize);
	SwapRedBlue(pixels, dataSize);

	// Create CGImage from BGRA pixel data
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGDataProviderRef provider = CGDataProviderCreateWithData(
		NULL, pixels, dataSize, pixelDataReleaseCallback
	);

	CGImageRef cgImage = CGImageCreate(
		width, height,
		8,                  // bits per component
		32,                 // bits per pixel
		width * 4,          // bytes per row
		colorSpace,
		kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst, // BGRA
		provider,
		NULL,               // decode array
		false,              // should interpolate
		kCGRenderingIntentDefault
	);

	NSCursor* nsCursor = nil;

	if (cgImage) {
		NSImage* nsImage = [[NSImage alloc] initWithCGImage:cgImage size:NSMakeSize(width, height)];
		if (nsImage) {
			nsCursor = [[NSCursor alloc] initWithImage:nsImage hotSpot:NSMakePoint(hotspot_x, hotspot_y)];
			[nsImage release];
		}
		CGImageRelease(cgImage);
	}

	CGDataProviderRelease(provider);
	CGColorSpaceRelease(colorSpace);

	return nsCursor;
}

static bool native_cursor_apply_impl(bool force) {
	auto cur = current.cursor;
	if (cur == nullptr || cur->count <= 0) return false;
	auto hc = cur->getCurrentCursor();
	if (hc == nil) return false;
	if (!force && hc == current.activeCursor) return true;
	current.activeCursor = hc;
	[hc set];
	return true;
}

// ==================== Implementation functions ====================

dllg gml_ptr<native_cursor> native_cursor_create_from_buffer(gml_buffer buf, int width, int height, int hotspot_x, int hotspot_y, double fps = 30) {
	auto cur = malloc_arr<native_cursor>(1);
	auto size = (width * height * 4);
	if (buf.size() < size) return nullptr;

	cur->init(1);
	cur->setFramerate(fps);

	auto cursor = CreateCursorFromPixels(buf.data(), width, height, hotspot_x, hotspot_y);
	cur->cursors[0] = cursor;
	if (cursor == nil) trace("Failed to create cursor");
	return cur;
}

dllg void native_cursor_add_from_buffer(gml_ptr<native_cursor> cursor, gml_buffer buf, int width, int height, int hotspot_x, int hotspot_y) {
	auto size = (width * height * 4);
	if (buf.size() < size) return;
	auto frame = cursor->addFrames(1);

	auto hcursor = CreateCursorFromPixels(buf.data(), width, height, hotspot_x, hotspot_y);
	cursor->cursors[frame] = hcursor;
	if (hcursor == nil) trace("Failed to create cursor");
}

dllg gml_ptr<native_cursor> native_cursor_create_empty() {
	auto cur = malloc_arr<native_cursor>(1);
	cur->init(0);
	return cur;
}

dllg gml_ptr<native_cursor> native_cursor_create_from_full_path(const char* path) {
	@autoreleasepool {
		auto cur = malloc_arr<native_cursor>(1);
		cur->init(1);

		NSString* nsPath = [NSString stringWithUTF8String:path];
		NSImage* image = [[NSImage alloc] initWithContentsOfFile:nsPath];
		if (image) {
			cur->cursors[0] = [[NSCursor alloc] initWithImage:image hotSpot:NSMakePoint(0, 0)];
			[image release];
		}
		return cur;
	}
}

dllg void native_cursor_add_from_full_path(gml_ptr<native_cursor> cursor, const char* path) {
	@autoreleasepool {
		auto i = cursor->addFrames(1);

		NSString* nsPath = [NSString stringWithUTF8String:path];
		NSImage* image = [[NSImage alloc] initWithContentsOfFile:nsPath];
		if (image) {
			cursor->cursors[i] = [[NSCursor alloc] initWithImage:image hotSpot:NSMakePoint(0, 0)];
			[image release];
		}
	}
}

dllg void native_cursor_set(gml_ptr<native_cursor> cursor) {
	current.cursor = cursor;
	if (nc_cursor_hidden) {
		[NSCursor unhide];
		nc_cursor_hidden = false;
	}
	if (game_window && !cursor_rects_disabled) {
		[game_window disableCursorRects];
		cursor_rects_disabled = true;
	}
	native_cursor_apply_impl(false);
	nc_start_timer();
}

dllg void native_cursor_reset() {
	nc_stop_timer();
	current.cursor = nullptr;
	current.activeCursor = nil;
	if (game_window && cursor_rects_disabled) {
		[game_window enableCursorRects];
		cursor_rects_disabled = false;
	}
	if (!nc_cursor_hidden) {
		[NSCursor hide];
		nc_cursor_hidden = true;
	}
}

dllg int native_cursor_get_frame(gml_ptr<native_cursor> cursor) {
	return cursor->getCurrentFrame();
}

dllg void native_cursor_set_frame(gml_ptr<native_cursor> cursor, int frame) {
	if (cursor->count <= 0) return;
	frame = frame % cursor->count;
	if (frame < 0) frame += cursor->count;
	cursor->currentFrame = frame;
}

dllg double native_cursor_get_framerate(gml_ptr<native_cursor> cursor) {
	return cursor->framerate;
}

dllg void native_cursor_set_framerate(gml_ptr<native_cursor> cursor, int fps) {
	cursor->setFramerate(fps);
}

dllg void native_cursor_destroy(gml_ptr_destroy<native_cursor> cursor) {
	if (cursor == current.cursor) {
		nc_stop_timer();
		current.cursor = nullptr;
		current.activeCursor = nil;
		if (game_window && cursor_rects_disabled) {
			[game_window enableCursorRects];
			cursor_rects_disabled = false;
		}
		if (!nc_cursor_hidden) {
			[NSCursor hide];
			nc_cursor_hidden = true;
		}
	}
	cursor->free_resources();
}

// ==================== Autogen glue (binary protocol wrappers) ====================

dllx double native_cursor_create_from_buffer_raw(void* _inout_ptr, double _inout_ptr_size, double _arg_width, double _arg_height) {
	gml_istream _in(_inout_ptr);
	gml_buffer _arg_buf = _in.read_gml_buffer();
	int _arg_hotspot_x = _in.read<int>();
	int _arg_hotspot_y = _in.read<int>();
	double _arg_fps;
	if (_in.read<bool>()) {
		_arg_fps = _in.read<double>();
	} else _arg_fps = 30;
	gml_ptr<native_cursor> _result = native_cursor_create_from_buffer(_arg_buf, (int)_arg_width, (int)_arg_height, _arg_hotspot_x, _arg_hotspot_y, _arg_fps);
	gml_ostream _out(_inout_ptr);
	_out.write<int64_t>((intptr_t)_result);
	return 1;
}

dllx double native_cursor_add_from_buffer_raw(void* _in_ptr, double _in_ptr_size, native_cursor* _arg_cursor, double _arg_width) {
	gml_istream _in(_in_ptr);
	gml_buffer _arg_buf = _in.read_gml_buffer();
	int _arg_height = _in.read<int>();
	int _arg_hotspot_x = _in.read<int>();
	int _arg_hotspot_y = _in.read<int>();
	native_cursor_add_from_buffer(_arg_cursor, _arg_buf, (int)_arg_width, _arg_height, _arg_hotspot_x, _arg_hotspot_y);
	return 1;
}

dllx double native_cursor_create_empty_raw(void* _inout_ptr, double _inout_ptr_size) {
	gml_istream _in(_inout_ptr);
	gml_ptr<native_cursor> _result = native_cursor_create_empty();
	gml_ostream _out(_inout_ptr);
	_out.write<int64_t>((intptr_t)_result);
	return 1;
}

dllx double native_cursor_create_from_full_path_raw(void* _inout_ptr, double _inout_ptr_size, const char* _arg_path) {
	gml_istream _in(_inout_ptr);
	gml_ptr<native_cursor> _result = native_cursor_create_from_full_path(_arg_path);
	gml_ostream _out(_inout_ptr);
	_out.write<int64_t>((intptr_t)_result);
	return 1;
}

dllx double native_cursor_add_from_full_path_raw(native_cursor* _arg_cursor, const char* _arg_path) {
	native_cursor_add_from_full_path(_arg_cursor, _arg_path);
	return 1;
}

dllx double native_cursor_set_raw(native_cursor* _arg_cursor) {
	native_cursor_set(_arg_cursor);
	return 1;
}

dllx double native_cursor_reset_raw() {
	native_cursor_reset();
	return 1;
}

dllx double native_cursor_get_frame_raw(native_cursor* _arg_cursor) {
	return native_cursor_get_frame(_arg_cursor);
}

dllx double native_cursor_set_frame_raw(native_cursor* _arg_cursor, double _arg_frame) {
	native_cursor_set_frame(_arg_cursor, (int)_arg_frame);
	return 1;
}

dllx double native_cursor_get_framerate_raw(native_cursor* _arg_cursor) {
	return native_cursor_get_framerate(_arg_cursor);
}

dllx double native_cursor_set_framerate_raw(native_cursor* _arg_cursor, double _arg_fps) {
	native_cursor_set_framerate(_arg_cursor, (int)_arg_fps);
	return 1;
}

dllx double native_cursor_destroy_raw(native_cursor* _arg_cursor) {
	native_cursor_destroy(_arg_cursor);
	return 1;
}

// ==================== Direct exports ====================

dllx void native_cursor_update() {
	auto cur = current.cursor;
	if (cur && cur->count > 0) {
		native_cursor_apply_impl(true);
	}
}

dllx double native_cursor_check_full_path(const char* path) {
	struct stat st;
	if (stat(path, &st) != 0) return 0;
	return (st.st_mode & S_IFDIR) == 0;
}

dllx void native_cursor_preinit_raw(void* _hwnd_as_ptr, double _swapBR) {
	SwapRedBlue_needed = _swapBR > 0.5;
	current.init();

	if (_hwnd_as_ptr) {
		game_window = (NSWindow*)_hwnd_as_ptr;
	}
}

// ==================== Static initialization ====================

static bool native_cursor_preinit_statics() {
	SwapRedBlue_needed = false;
	current.init();
	return true;
}

static bool __ready__ = native_cursor_preinit_statics();
