/// @desc 

draw_sprite(sprite_index,image_index,round(x),round(y));

if (shootEyesPercent != 0) {
	draw_sprite_ext(sprite_index,5,round(x),round(y),1,1,0,merge_color(c_white,c_red,shootEyesPercent),1);
}

if (mouthYPercent != 0) {
	draw_sprite_ext(sprite_index,3,round(x),round(y),image_xscale,image_yscale,image_angle,c_white,Wave(0.7,1,0.3,0)*mouthBurnPercent*mouthYPercent);
}