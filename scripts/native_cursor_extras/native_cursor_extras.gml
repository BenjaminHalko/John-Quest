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

function native_cursor(_ptr) constructor {
	__ptr__ = _ptr;
}

function setCursor(_type) {
	if (global.currentCursorType != _type) {
		global.currentCursorType = _type;
		native_cursor_set(global.cursors[_type]);
	}
}

function destroyCursors() {
	for(var i = 0; i < array_length(global.cursors); i++) {
		native_cursor_destroy(global.cursors[i]);	
	}
}

function createCursors() {
	var _cursors = [
		sCursor,
		sCursorHover,
		sCursorForward,
		sCursorLeft,
		sCursorRight,
		sCursorBackwardLeft,
		sCursorBackwardRight,
		sCursorLvl4
	];
	var _numCursors = array_length(_cursors);
	if (array_length(global.cursors) != _numCursors) global.cursors = array_create(_numCursors);

	var _size = max(min(window_get_width()/480,window_get_height()/270)/2,0.5);
	for(var i = 0; i < _numCursors; i++) {
		global.cursors[i] = native_cursor_create_from_sprite_ext(_cursors[i],0,_size,_size,c_white,1);
	}
	
	var _type = global.currentCursorType;
	global.currentCursorType = -1;
	setCursor(_type);
}