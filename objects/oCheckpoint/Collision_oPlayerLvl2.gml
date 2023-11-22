/// @desc 

var _x = x+sprite_width/2;
var _y = y+sprite_height/2;
if (global.saveX != _x or global.saveY != _y) {
	global.saveX = _x;
	global.saveY = _y;
	global.saveDir = dir;
	SaveLvl2();
}