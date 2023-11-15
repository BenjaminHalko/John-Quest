/// @desc 

if (shrink) {
	radius = Approach(radius, 0, 6);
	if (radius <= 0) instance_destroy();
} else {
	radius += 0.5;
	
	if (global.audioTick) {
		if (--counter <= 0) shrink = true;	
	}
}

x = xstart + random_range(-2,2);
y = ystart + random_range(-2,2);

flash = Approach(flash, 0, 0.05);

if (collision_circle(x,y,radius,oPlayer,false,false)) {
	oPlayer.hurtPlayer();
	var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
	oPlayer.hsp = lengthdir_x(8,_dir);
	oPlayer.vsp = lengthdir_y(8,_dir);
}