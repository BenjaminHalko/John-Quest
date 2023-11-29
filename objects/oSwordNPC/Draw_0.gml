/// @desc 

// Inherit the parent event
event_inherited();


if (global.questStatusHat == 2) {
	if (flash != 0)
	{
		shader_set(shFlash);
		shader_set_uniform_f(global.uFlashPercent,flash);
		shader_set_uniform_f_array(global.uFlashColor,flashColor);
	}
	draw_sprite_ext(sHat,0,floor(x-2*image_xscale),floor(y-24-z),image_xscale,1,0,c_white,1);
	if(shader_current() != -1) shader_reset();
}