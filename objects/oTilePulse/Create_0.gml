if (timer > 0) {
	var _rand = irandom(3);
	for(var i = 0; i < 4; i++) {
		var _x = x+lengthdir_x(16,(i+_rand % 4)*90);
		var _y = y+lengthdir_y(16,(i+_rand % 4)*90);
		if (!place_meeting(_x,_y,oTilePulse) and tilemap_get_at_pixel(global.collisionMap, _x, _y) == 1) {
			instance_create_depth(_x,_y,depth,oTilePulse, {timer: --timer});
		}
	}
}