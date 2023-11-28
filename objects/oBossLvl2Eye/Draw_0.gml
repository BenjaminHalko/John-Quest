/// @desc 

if (oBossLvl2.flash != 0)
{
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent,oBossLvl2.flash);
	shader_set_uniform_f_array(global.uFlashColor,oBossLvl2.flashColor);
}
draw_self();
if(shader_current() != -1) shader_reset();

if (oBossLvl2.deadPercent*oBossLvl2.shootPercent > 0) {
	var _col = choose(#dd0000,#221100);
	draw_sprite_ext(sprite_index,1,x,y,image_xscale,image_yscale,image_angle,_col,min(1,oBossLvl2.deadPercent*oBossLvl2.shootPercent));	
}