
shader_set(shFlash);
shader_set_uniform_f(global.uFlashColor, 1,1,1);
shader_set_uniform_f(global.uFlashPercent, flash);
draw_self();
shader_reset();