/// @desc 

enableLive;

flash = Approach(flash, 0, 0.1);

if (global.audioTick) counter--;

if (image_alpha != 1) {
	image_alpha += 0.005;
	if (counter <= 0) {
		image_alpha = 1;
		flash = 1;
	}
} else {
	if (place_meeting(x,y,oPlayer)) {
		oPlayer.hurtPlayer();
		var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
		oPlayer.hsp = lengthdir_x(12, _dir);
		oPlayer.vsp = lengthdir_y(12, _dir);	
	}
	
	if (counter <= -2) {
		scale = Approach(scale, 0, 0.2);
		if (scale == 0) instance_destroy();
	}
}

if (oLvl1Boss.inBetweenPhases) {
	image_xscale = ApproachFade(image_xscale,0,0.1,0.7);
	if (image_xscale <= 0) instance_destroy();
} else {
	image_xscale = scale + flash;
}
image_yscale = image_xscale;