/// @desc 

enableLive;

depth = -bbox_bottom;

if (oBossLvl2.eyeExpandPercent > 0.4) depth -= oBossLvl2.yEyeOffset;

if (size == 0) {
	image_xscale = xscale;
	image_yscale = yscale;
	sprite_index = sBossLvl2EyeSmall;
} else {
	image_xscale = (0.5+size/2) * xscale;
	image_yscale = (0.5+size/2) * yscale;
	image_yscale = (0.5+size/2) * yscale;
	sprite_index = sBossLvl2Eye;
}

image_blend = merge_color(#aaaaaa,c_white,size);

if (place_meeting(x,y,oPlayer) and !oBossLvl2.intro) {
	oPlayer.hurtPlayer(point_direction(x,y,oPlayer.x,oPlayer.y),32,1);
}