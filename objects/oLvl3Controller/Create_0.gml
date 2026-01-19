/// @desc 

#macro INVENTORY_Y 200



// Cursor
global.mx = RESOLUTION_W / 2;
global.my = RESOLUTION_H / 2;
windowWidth = window_get_width();
windowHeight = window_get_height();
window_mouse_set(windowWidth * 0.5, windowHeight * 0.5);
global.cursors = [];
global.currentCursorType = 0;

if (!global.introLvl3 and !Load("lvl3","seenIntro",false)) {
	global.nodes = [];
	Transition(rLvl3Intro,1);
	room_goto(rLvl3Intro);
} else {
	createCursors();
}