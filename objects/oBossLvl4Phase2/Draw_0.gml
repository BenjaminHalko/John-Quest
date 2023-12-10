/// @desc 

enableLive;

draw_self();

if (shootEyesPercent != 0) {
	draw_sprite_ext(sprite_index,5,x,y,1,1,0,merge_color(c_white,c_red,shootEyesPercent),1);
}

if (mouthYPercent != 0) {
	draw_sprite_ext(sprite_index,3,x,y,image_xscale,image_yscale,image_angle,c_white,Wave(0.7,1,0.3,0)*mouthBurnPercent*mouthYPercent);
}