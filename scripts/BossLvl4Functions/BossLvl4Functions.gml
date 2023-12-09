function DrawLvl4BossEye(_focusX, _focusY) {
	if (live_call(_focusX, _focusY)) return live_result;
	
	surface_set_target(surf);
	draw_clear_alpha(c_black,0);
	if (flash != 0) {
		shader_set(shFlash);
		shader_set_uniform_f(global.uFlashPercent,flash);
		shader_set_uniform_f(global.uFlashColor, 237 / 255, 0, 100 / 255);
	}
	draw_sprite(sprite_index,0,xOffset,yOffset);
	if (flash != 0) shader_reset();
	
	gpu_set_colorwriteenable(1,1,1,0);
	
	var _angle = point_direction(x,y,_focusX,_focusY);
	var _dist = min(6,point_distance(x,y,_focusX,_focusY)) * (1-min(1,flash*3));
	
	if (flash != 0) {
		shader_set(shFlash);
		shader_set_uniform_f(global.uFlashPercent,flash);
		var _col = make_color_hsv(random(255),255,255);
		shader_set_uniform_f(global.uFlashColor, color_get_red(_col)/255, color_get_green(_col)/255, color_get_blue(_col)/255);
	}
	draw_sprite_ext(sprite_index,1,xOffset+lengthdir_x(_dist,_angle),yOffset+lengthdir_y(_dist,_angle),1-flash*0.25,1+flash*0.5,0,c_white,1);
	if (flash != 0) shader_reset();
	
	gpu_set_colorwriteenable(1,1,1,1);
	surface_reset_target();

	var _offsetLen = point_distance(0,0,sprite_xoffset,sprite_yoffset);
	var _offsetDir = point_direction(sprite_xoffset,sprite_yoffset,0,0)+image_angle;
	
	draw_surface_ext(surf,x+lengthdir_x(_offsetLen,_offsetDir),y+lengthdir_y(_offsetLen,_offsetDir),image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}

function HomingEyeInit() {
	if (live_call()) return live_result;
	
	targetDir = 0;
	moveDir = 0;
	dirPercent = 0;
	waitPercent = 0;
	spd = 8;
	targetX = 0;
	targetY = 0;
	curve = animcurve_get_channel(BossLvl4Curves,"hexagon");
}

function moveToPoint(_x,_y) {
	dir = point_direction(x,y,_x,_y);
	var _dist = point_distance(x,y,_x,_y);
	spd = ApproachFade(spd,min(_dist/8,4),0.3,0.7);
	if (_dist < spd) {
		x = _x;
		y = _y;
	} else {
		x += lengthdir_x(spd, dir);
		y += lengthdir_y(spd, dir);
	}	
}