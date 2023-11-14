/// @desc 

enableLive;

var _wave = sin(((oMusicController.thisBeat % 1) + waveOffset) * pi * 2) * 2.5;
x = xstart + lengthdir_x(_wave,dir-90);
y = ystart + lengthdir_y(_wave,dir-90);

if (destroy) {
	image_xscale = Approach(image_xscale, 0, 0.1);
	image_yscale = image_xscale;
	
	if (image_xscale <= 0) instance_destroy();
}

if (place_meeting(x,y,oPlayer)) {
	oPlayer.hurtPlayer();
	var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
	oPlayer.hsp = lengthdir_x(8,_dir);
	oPlayer.vsp = lengthdir_y(8,_dir);
}