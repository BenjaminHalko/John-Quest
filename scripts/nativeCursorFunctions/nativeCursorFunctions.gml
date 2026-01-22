enum CURSOR {
	NORMAL,
	HOVER,
	FORWARD,
	LEFT,
	RIGHT,
	BACKWARD_LEFT,
	BACKWARD_RIGHT,
	LVL4
}
global.hasNativeCursor = (os_type == os_windows);
global.cursorSprites = [
	sCursor,
	sCursorHover,
	sCursorForward,
	sCursorLeft,
	sCursorRight,
	sCursorBackwardLeft,
	sCursorBackwardRight,
	sCursorLvl4
];

function native_cursor(_ptr) constructor {
	__ptr__ = _ptr;
}

function setCursor(_type) {
	if (global.currentCursorType != _type) {
        if (!global.hasNativeCursor) {
            window_set_cursor(cr_none);
        }
		global.currentCursorType = _type;
        if (_type == -1) {
            if (global.hasNativeCursor) native_cursor_reset();
            else cursor_sprite = -1;
        } else {
            if (global.hasNativeCursor) native_cursor_set(global.cursors[_type]);
            else cursor_sprite = global.cursors[_type];
        }
	}
}

function destroyCursors() {
	if (global.hasNativeCursor) {
		native_cursor_reset();
		for(var i = 0; i < array_length(global.cursors); i++) {
			native_cursor_destroy(global.cursors[i]);	
		}
	} else {
		cursor_sprite = -1;
		for(var i = 0; i < array_length(global.cursors); i++) {
			sprite_delete(global.cursors[i]);
		}
	}
	global.cursors = [];
}

function createCursors() {
	var _numCursors = array_length(global.cursorSprites);
	if (array_length(global.cursors) != _numCursors) global.cursors = array_create(_numCursors);

	var _size = max(min(window_get_width()/480,window_get_height()/270)/2,0.5);
	for(var i = 0; i < _numCursors; i++) {
		if (global.hasNativeCursor) {
			global.cursors[i] = native_cursor_create_from_sprite_ext(global.cursorSprites[i],0,_size,_size,c_white,1);
		} else {
			var _spriteWidth = ceil(sprite_get_width(global.cursorSprites[i])*_size);
			var _spriteHeight = ceil(sprite_get_height(global.cursorSprites[i])*_size);
			var _spriteXOffset = round(sprite_get_xoffset(global.cursorSprites[i])*_size);
			var _spriteYOffset = round(sprite_get_yoffset(global.cursorSprites[i])*_size);
			var _surf = surface_create(_spriteWidth,_spriteHeight);
			surface_set_target(_surf);
			draw_sprite_ext(global.cursorSprites[i],0,_spriteXOffset,_spriteYOffset,_size,_size,0,c_white,1);
			surface_reset_target();
			global.cursors[i] = sprite_create_from_surface(_surf,0,0,_spriteWidth,_spriteHeight,false,false,_spriteXOffset,_spriteYOffset);
			surface_free(_surf);
		}
	}
	
	var _type = global.currentCursorType;
	global.currentCursorType = -1;
	setCursor(_type);
}