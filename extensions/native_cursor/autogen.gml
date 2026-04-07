#define native_cursor_create_from_buffer
/// native_cursor_create_from_buffer(buf:buffer, width:int, height:int, hotspot_x:int, hotspot_y:int, fps:number = 30)->
var _buf = native_cursor_prepare_buffer(33);
var _val_0 = argument[0];
if (buffer_exists(_val_0)) {
	buffer_write(_buf, buffer_u64, int64(buffer_get_address(_val_0)));
	buffer_write(_buf, buffer_s32, buffer_get_size(_val_0));
	buffer_write(_buf, buffer_s32, buffer_tell(_val_0));
} else {
	buffer_write(_buf, buffer_u64, 0);
	buffer_write(_buf, buffer_s32, 0);
	buffer_write(_buf, buffer_s32, 0);
}
buffer_write(_buf, buffer_s32, argument[3]);
buffer_write(_buf, buffer_s32, argument[4]);
if (argument_count >= 6) {
	buffer_write(_buf, buffer_bool, true);
	buffer_write(_buf, buffer_f64, argument[5]);
} else buffer_write(_buf, buffer_bool, false);
if (native_cursor_create_from_buffer_raw(buffer_get_address(_buf), 33, argument[1], argument[2])) {
	buffer_seek(_buf, buffer_seek_start, 0);
	// GMS >= 2.3:
	var _ptr_0 = buffer_read(_buf, buffer_u64);
	var _box_0;
	if (_ptr_0 != 0) {
		_box_0 = new native_cursor(ptr(_ptr_0));
	} else _box_0 = undefined;
	return _box_0;
	/*/
	var _ptr_0 = buffer_read(_buf, buffer_u64);
	var _box_0;
	if (_ptr_0 != 0) {
		_box_0 = array_create(2);
		_box_0[0] = global.__ptrt_native_cursor;
		_box_0[1] = ptr(_ptr_0);
	} else _box_0 = undefined;
	return _box_0;
	//*/
} else return undefined;

#define native_cursor_add_from_buffer
/// native_cursor_add_from_buffer(cursor, buf:buffer, width:int, height:int, hotspot_x:int, hotspot_y:int)
var _buf = native_cursor_prepare_buffer(28);
// GMS >= 2.3:
if (instanceof(argument0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (argument0.__ptr__ == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
var _val_0 = argument1;
if (buffer_exists(_val_0)) {
	buffer_write(_buf, buffer_u64, int64(buffer_get_address(_val_0)));
	buffer_write(_buf, buffer_s32, buffer_get_size(_val_0));
	buffer_write(_buf, buffer_s32, buffer_tell(_val_0));
} else {
	buffer_write(_buf, buffer_u64, 0);
	buffer_write(_buf, buffer_s32, 0);
	buffer_write(_buf, buffer_s32, 0);
}
buffer_write(_buf, buffer_s32, argument3);
buffer_write(_buf, buffer_s32, argument4);
buffer_write(_buf, buffer_s32, argument5);
/*/
if (argument0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
var _val_0 = argument1;
if (buffer_exists(_val_0)) {
	buffer_write(_buf, buffer_u64, int64(buffer_get_address(_val_0)));
	buffer_write(_buf, buffer_s32, buffer_get_size(_val_0));
	buffer_write(_buf, buffer_s32, buffer_tell(_val_0));
} else {
	buffer_write(_buf, buffer_u64, 0);
	buffer_write(_buf, buffer_s32, 0);
	buffer_write(_buf, buffer_s32, 0);
}
buffer_write(_buf, buffer_s32, argument3);
buffer_write(_buf, buffer_s32, argument4);
buffer_write(_buf, buffer_s32, argument5);
//*/
// GMS >= 2.3:
native_cursor_add_from_buffer_raw(buffer_get_address(_buf), 28, argument0.__ptr__, argument2)
/*/
native_cursor_add_from_buffer_raw(buffer_get_address(_buf), 28, argument0[1], argument2)
//*/

#define native_cursor_create_empty
/// native_cursor_create_empty()->
var _buf = native_cursor_prepare_buffer(8);
if (native_cursor_create_empty_raw(buffer_get_address(_buf), 8)) {
	// GMS >= 2.3:
	var _ptr_0 = buffer_read(_buf, buffer_u64);
	var _box_0;
	if (_ptr_0 != 0) {
		_box_0 = new native_cursor(ptr(_ptr_0));
	} else _box_0 = undefined;
	return _box_0;
	/*/
	var _ptr_0 = buffer_read(_buf, buffer_u64);
	var _box_0;
	if (_ptr_0 != 0) {
		_box_0 = array_create(2);
		_box_0[0] = global.__ptrt_native_cursor;
		_box_0[1] = ptr(_ptr_0);
	} else _box_0 = undefined;
	return _box_0;
	//*/
} else return undefined;

#define native_cursor_create_from_full_path
/// native_cursor_create_from_full_path(path:string)->
var _buf = native_cursor_prepare_buffer(8);
if (native_cursor_create_from_full_path_raw(buffer_get_address(_buf), 8, argument0)) {
	// GMS >= 2.3:
	var _ptr_0 = buffer_read(_buf, buffer_u64);
	var _box_0;
	if (_ptr_0 != 0) {
		_box_0 = new native_cursor(ptr(_ptr_0));
	} else _box_0 = undefined;
	return _box_0;
	/*/
	var _ptr_0 = buffer_read(_buf, buffer_u64);
	var _box_0;
	if (_ptr_0 != 0) {
		_box_0 = array_create(2);
		_box_0[0] = global.__ptrt_native_cursor;
		_box_0[1] = ptr(_ptr_0);
	} else _box_0 = undefined;
	return _box_0;
	//*/
} else return undefined;

#define native_cursor_add_from_full_path
/// native_cursor_add_from_full_path(cursor, path:string)
// no buffer!
// GMS >= 2.3:
if (instanceof(argument0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (argument0.__ptr__ == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
/*/
if (argument0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
//*/
// GMS >= 2.3:
native_cursor_add_from_full_path_raw(argument0.__ptr__, argument1)
/*/
native_cursor_add_from_full_path_raw(argument0[1], argument1)
//*/

#define native_cursor_set
/// native_cursor_set(cursor)
// no buffer!
// GMS >= 2.3:
if (instanceof(argument0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (argument0.__ptr__ == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
/*/
if (argument0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
//*/
// GMS >= 2.3:
native_cursor_set_raw(argument0.__ptr__)
/*/
native_cursor_set_raw(argument0[1])
//*/

#define native_cursor_reset
/// native_cursor_reset()
// no buffer!
native_cursor_reset_raw()

#define native_cursor_get_frame
/// native_cursor_get_frame(cursor)->int
// no buffer!
// GMS >= 2.3:
if (instanceof(argument0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (argument0.__ptr__ == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
/*/
if (argument0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
//*/
// GMS >= 2.3:
return native_cursor_get_frame_raw(argument0.__ptr__);
/*/
return native_cursor_get_frame_raw(argument0[1]);
//*/

#define native_cursor_set_frame
/// native_cursor_set_frame(cursor, frame:int)
// no buffer!
// GMS >= 2.3:
if (instanceof(argument0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (argument0.__ptr__ == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
/*/
if (argument0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
//*/
// GMS >= 2.3:
native_cursor_set_frame_raw(argument0.__ptr__, argument1)
/*/
native_cursor_set_frame_raw(argument0[1], argument1)
//*/

#define native_cursor_get_framerate
/// native_cursor_get_framerate(cursor)->number
// no buffer!
// GMS >= 2.3:
if (instanceof(argument0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (argument0.__ptr__ == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
/*/
if (argument0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
//*/
// GMS >= 2.3:
return native_cursor_get_framerate_raw(argument0.__ptr__);
/*/
return native_cursor_get_framerate_raw(argument0[1]);
//*/

#define native_cursor_set_framerate
/// native_cursor_set_framerate(cursor, fps:int)
// no buffer!
// GMS >= 2.3:
if (instanceof(argument0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (argument0.__ptr__ == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
/*/
if (argument0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(argument0), true); exit }
if (int64(argument0[1]) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
//*/
// GMS >= 2.3:
native_cursor_set_framerate_raw(argument0.__ptr__, argument1)
/*/
native_cursor_set_framerate_raw(argument0[1], argument1)
//*/

#define native_cursor_destroy
/// native_cursor_destroy(cursor)
// no buffer!
// GMS >= 2.3:
var _box_0 = argument0;
if (instanceof(_box_0) != "native_cursor") { show_error("Expected a native_cursor, got " + string(_box_0), true); exit }
var _ptr_0 = _box_0.__ptr__
var _ptr_0 = _box_0.__ptr__;
if (_ptr_0 == pointer_null) { show_error("This native_cursor is destroyed.", true); exit; }
_box_0.__ptr__ = pointer_null;
/*/
var _box_0 = argument0;
if (_box_0[0] != global.__ptrt_native_cursor) { show_error("Expected a native_cursor, got " + string(_box_0), true); exit }
var _ptr_0 = _box_0[1]
var _ptr_0 = _box_0[1];
if (int64(_ptr_0) == 0) { show_error("This native_cursor is destroyed.", true); exit; }
_box_0[@1] = ptr(0);
//*/
// GMS >= 2.3:
native_cursor_destroy_raw(_ptr_0)
/*/
native_cursor_destroy_raw(_ptr_0)
//*/

