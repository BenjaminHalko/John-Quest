/// @desc 

if (flash != 0) {
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent,flash);
	shader_set_uniform_f(global.uFlashColor,1,1,1);
}

DrawLvl4BossEye(x+lerp(lastFocusX,focusX,focusPercent),y+lerp(lastFocusY,focusY,focusPercent));

if (flash != 0) shader_reset();