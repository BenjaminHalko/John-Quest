/// @desc 

if (flash != 0) {
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent,flash);
	shader_set_uniform_f(global.uFlashColor,1,1,1);
}

draw_sprite_ext(sprite_index,image_index,x,y,scale,1/scale,angle,image_blend,image_alpha);

if (flash != 0) shader_reset();