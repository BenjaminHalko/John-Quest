/// @desc 

enableLive;

draw_self();

if (mouthYPercent != 0) {
	draw_sprite_ext(sprite_index,3,x,y,image_xscale,image_yscale,image_angle,c_white,Wave(0.7,1,0.3,0)*mouthBurnPercent*mouthYPercent);
}