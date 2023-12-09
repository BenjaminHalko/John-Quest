/// @desc 

if (!global.defeatedBoss and !instance_exists(oBossLvl4Phase1)) {
	var _x = x+sprite_width/2;
	var _y = y+sprite_height/2;
	if (global.saveX != _x or global.saveY != _y) {
		global.saveX = _x;
		global.saveY = _y;
		Save("lvl4","x",_x);
		Save("lvl4","y",_y);
	}

	oPlayer.restoreHealth = true;
}