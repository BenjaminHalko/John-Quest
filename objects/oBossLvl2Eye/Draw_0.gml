/// @desc 

if (oBossLvl2.flash != 0)
{
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent,oBossLvl2.flash);
	shader_set_uniform_f_array(global.uFlashColor,oBossLvl2.flashColor);
}
draw_self();
if(shader_current() != -1) shader_reset();