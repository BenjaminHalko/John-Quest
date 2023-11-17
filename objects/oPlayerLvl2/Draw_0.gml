/// @desc 

draw_sprite_ext(sPlayerShadow,0,floor(x),floor(y),xscale,1,0,c_white,1);
if (flash != 0) {
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent,flash);
	shader_set_uniform_f(global.uFlashColor,1,1,1);
}

draw_sprite_pos(sprite_index,image_index,
	floor(x)-wHalf*xscale+topShift,floor(y)-wHalf*2*yscale+wHalf,
	floor(x)+wHalf*xscale+topShift,floor(y)-wHalf*2*yscale+wHalf,
	floor(x)+wHalf*xscale,floor(y)+wHalf,
	floor(x)-wHalf*xscale,floor(y)+wHalf,
image_alpha);

if (flash != 0) shader_reset();