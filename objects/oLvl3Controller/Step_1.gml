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
    
    window_mouse_set(global.mx * windowWidth / RESOLUTION_W, global.my * windowHeight / RESOLUTION_H);
}
