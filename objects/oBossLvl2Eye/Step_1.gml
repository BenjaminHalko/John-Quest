/// @desc 

enableLive;

depth = -bbox_bottom;

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