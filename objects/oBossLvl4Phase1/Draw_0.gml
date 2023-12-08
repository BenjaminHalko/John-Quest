/// @desc 

if (flash != 0) {
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent,flash);
	shader_set_uniform_f(global.uFlashColor,1,1,1);
}

var _yscale = 1/scale;
if (vSpd > 0) _yscale = scale;
draw_sprite_ext(sprite_index,image_index,x,y,scale,_yscale,angle,image_blend,image_alpha);

if (flash != 0) shader_reset();

// Mushroom
if (explosionCount == maxExplosions+1) {
	draw_sprite(sBossLvl4Mushroom,0,bCenterX,mushroomY);	
}