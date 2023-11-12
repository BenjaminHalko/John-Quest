function DrawBossLvl1(_surface) {
	if (live_call(_surface)) return live_result;
	
	var _turnAngle = image_angle + (point_direction(x, y, oPlayer.x, oPlayer.y) - 180) / 10;
	
	// Reset Bloom Surface
	surface_reset_target();
	
	// Draw Eye
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent, flash);
	shader_set_uniform_f_array(global.uFlashColor, choose([0.8,0,0],[0.2,0.1,0]));
	var _index = 0;
	if (flash > 0) _index = image_index;

	// Draw Eyes
	draw_sprite(sprite_index, _index, sprite_xoffset, sprite_yoffset);

	gpu_set_colorwriteenable(1, 1, 1, 0);

	var _radius = 8 - 5 * (sprite_index == sLvl1BossSmall);
	var _angle = point_direction(x, y, oPlayer.x, oPlayer.y) - _turnAngle;
	var _drawX = sprite_xoffset + lengthdir_x(_radius, _angle) + random_range(-5, 5) * min(4, flash + oLvl1Boss.bigFlash * 4);
	var _drawY = sprite_yoffset + lengthdir_y(_radius*2, _angle) + random_range(-5, 5) * min(4, flash + oLvl1Boss.bigFlash * 4);
	var _col = make_color_hsv(random(255),255,255);
	shader_set_uniform_f(global.uFlashColor, color_get_red(_col)/255, color_get_green(_col)/255, color_get_blue(_col)/255);

	draw_sprite_ext((sprite_index == sLvl1BossSmall) ? sLvl1BossSmallIris : sLvl1BossIris, _index, _drawX, _drawY, 1+flash, 1+flash*2, _angle-180, c_white, 1);

	shader_reset();
	gpu_set_colorwriteenable(1, 1, 1, 1);
	surface_reset_target();
	
	// Set Bloom Surface
	surface_set_target(oBloom.surfacePing);
	camera_apply(view_camera[0]);
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashColor, 1,1,1);
	shader_set_uniform_f(global.uFlashPercent, oLvl1Boss.bigFlash);

	var _scale = 1 + flash * 0.2;
	var _len = point_distance(0,0,sprite_xoffset,sprite_yoffset)*_scale;
	var _dir = point_direction(sprite_xoffset,sprite_yoffset,0,0) + _turnAngle;
	var _extra = random_range(-10,10) * flash;
	var _x = x+lengthdir_x(_len, _dir+_extra)+random_range(-5, 5) * min(4, flash + oLvl1Boss.bigFlash * 3);
	var _y = y+lengthdir_y(_len, _dir+_extra)+random_range(-5, 5) * min(4, flash + oLvl1Boss.bigFlash * 3);
	draw_surface_ext(_surface, _x, _y, image_xscale*_scale, image_yscale*_scale, _turnAngle, c_white, image_alpha);

	shader_reset();
}