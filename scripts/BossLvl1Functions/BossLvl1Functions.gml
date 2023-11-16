function DrawBossLvl1(_surface) {
	var _turnAngle = image_angle + (point_direction(x, y, oPlayer.x, oPlayer.y) - 180) / 10;
	
	// Reset Bloom Surface
	surface_reset_target();
	
	// Draw Eye
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	shader_set(shFlash);
	if (oBossLvl1.shootPulse > 0) {
		shader_set_uniform_f(global.uFlashPercent, oBossLvl1.shootPulse);
		shader_set_uniform_f(global.uFlashColor, 237 / 255, 0, 140 / 255);
	} else {
		shader_set_uniform_f(global.uFlashPercent, flash * (1 - dead * 0.5));
		shader_set_uniform_f_array(global.uFlashColor, choose([0.8,0,0],[0.2,0.1,0]));
	}
	var _index = (oBossLvl1.phase == 5 and !oBossLvl1.dead);
	if (oBossLvl1.introPhase == 3) _index = 1;
	else if (flash > 0) _index = image_index;

	// Draw Eyes
	draw_sprite(sprite_index, _index, sprite_xoffset, sprite_yoffset);

	gpu_set_colorwriteenable(1, 1, 1, 0);

	var _radius = (8 - 5 * (sprite_index == sBossLvl1Small)) * (1 - oBossLvl1.stunned) * oBossLvl1.introEyePercent;
	var _angle = (lerp(point_direction(x, y, oPlayer.x, oPlayer.y) - _turnAngle, 180, oBossLvl1.stunned)) * oBossLvl1.introEyePercent;
	
	var _drawX = sprite_xoffset + lengthdir_x(_radius, _angle) + random_range(-5, 5) * min(4, flash + oBossLvl1.bigFlash * 4);
	var _drawY = sprite_yoffset + lengthdir_y(_radius*2, _angle) + random_range(-5, 5) * min(4, flash + oBossLvl1.bigFlash * 4);
	 if (oBossLvl1.shootPulse == 0) {
		var _col = make_color_hsv(random(255),255,255);
		shader_set_uniform_f(global.uFlashColor, color_get_red(_col)/255, color_get_green(_col)/255, color_get_blue(_col)/255);
	} else if (!dead) {
		shader_set_uniform_f(global.uFlashPercent, oBossLvl1.shootPulse);
		shader_set_uniform_f(global.uFlashColor, 0,0,0);
	} else {
		shader_set_uniform_f(global.uFlashPercent, 1);
		shader_set_uniform_f(global.uFlashColor, 1, 1, 1);
	}

	if (oBossLvl1.blink != 4 and oBossLvl1.intro) {
		var _percent = 0.5 - cos(oBossLvl1.blink * pi) / 2;
		draw_sprite_part_ext(sBossLvl1Iris, 0, 12 * _percent, 0, 24 * (1 - _percent), 6, _drawX-12*(1-_percent), _drawY-3, 1, 1, c_white, 1);
	} else {
		var _eyeIndex = 0;
		if (flash > 0) _eyeIndex = image_index;
		draw_sprite_ext((sprite_index == sBossLvl1Small) ? sBossLvl1SmallIris : sBossLvl1Iris, _eyeIndex, _drawX, _drawY, 1+flash+oBossLvl1.stunned/2, 1+flash*2+oBossLvl1.stunned/2, _angle-180, c_white, 1);
	}

	shader_reset();
	gpu_set_colorwriteenable(1, 1, 1, 1);
	surface_reset_target();
	
	// Set Bloom Surface
	surface_set_target(oBloom.surfacePing);
	camera_apply(view_camera[0]);
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashColor, 1,1,1);
	shader_set_uniform_f(global.uFlashPercent, min(1, oBossLvl1.bigFlash + oBossLvl1.deadFlash));
	var _scale = (1 + oBossLvl1.shootPulse / 3 + flash * 0.2 * (1 + dead) + oBossLvl1.deadFlash * 0.75) * scale;
	var _len = point_distance(0,0,sprite_xoffset,sprite_yoffset)*_scale;
	var _dir = point_direction(sprite_xoffset,sprite_yoffset,0,0) + _turnAngle;
	var _extra = random_range(-10,10) * flash;
	var _x = x+lengthdir_x(_len, _dir+_extra)+random_range(-5, 5) * min(4, flash + oBossLvl1.bigFlash * 3) + random_range(-2, 2) * oBossLvl1.stunned;
	var _y = y+lengthdir_y(_len, _dir+_extra)+random_range(-5, 5) * min(4, flash + oBossLvl1.bigFlash * 3) + random_range(-2, 2) * oBossLvl1.stunned;
	draw_surface_ext(_surface, _x, _y, image_xscale*_scale, image_yscale*_scale, _turnAngle, c_white, image_alpha);

	shader_reset();
}