/// @desc 

shader_set(shFlash);
shader_set_uniform_f(global.uFlashColor, 1,1,1);
shader_set_uniform_f(global.uFlashPercent, bigFlash);

// Draw Eye
surface_reset_target();
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
gpu_set_colorwriteenable(1, 1, 1, 0);

var _radius = 10;

var _angle = point_direction(x, y, oPlayer.x, oPlayer.y);
var _drawX = sprite_xoffset + lengthdir_x(_radius, _angle);
var _drawY = sprite_yoffset + lengthdir_y(_radius, _angle);

draw_sprite(sLvl1BossIris, 0, _drawX, _drawY);
gpu_set_colorwriteenable(1, 1, 1, 1);
surface_reset_target();

// Set the bloom surface
surface_set_target(oBloom.surfacePing);
camera_apply(view_camera[0]);
draw_surface_ext(surf, x - sprite_xoffset, y - sprite_yoffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

shader_reset();