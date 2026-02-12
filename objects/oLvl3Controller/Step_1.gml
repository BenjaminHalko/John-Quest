/// @desc 

// Cursors
if (windowWidth != window_get_width() or windowHeight != window_get_height()) {
	windowWidth = window_get_width();
	windowHeight = window_get_height();
	createCursors();
}

// Input
global.mx = InputMouseGuiX();
global.my = InputMouseGuiY();
global.clicked = InputPressed(INPUT_VERB.ATTACK);

var _mx = InputX(INPUT_CLUSTER.NAVIGATION);
var _my = InputY(INPUT_CLUSTER.NAVIGATION);

if (_mx != 0 or _my != 0) {
    global.mx = clamp(global.mx + _mx * 6, 2, RESOLUTION_W - 14);
    global.my = clamp(global.my + _my * 6, 2, RESOLUTION_H - 12);
    
    var _pos = application_get_position();
    
    window_mouse_set(_pos[0] + global.mx * (_pos[2] - _pos[0]) / RESOLUTION_W, _pos[1] + global.my * (_pos[3] - _pos[1]) / RESOLUTION_H);
}
