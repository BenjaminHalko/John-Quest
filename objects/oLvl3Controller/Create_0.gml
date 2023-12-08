/// @desc 

#macro INVENTORY_Y 200



// Cursor
windowWidth = window_get_width();
windowHeight = window_get_height();
global.cursors = [];
global.currentCursorType = 0;

if (global.introLvl3 != 1 and !Load("lvl3","seenIntro",false)) {
	global.nodes = [];
	Transition(rLvl3Intro,1);
	room_goto(rLvl3Intro);
} else {
	createCursors();
}