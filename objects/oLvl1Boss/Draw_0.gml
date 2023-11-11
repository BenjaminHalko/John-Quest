/// @desc 

enableLive;

// Draw Eye
surface_reset_target();
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
shader_set(shFlash);
shader_set_uniform_f(global.uFlashPercent, flash);
shader_set_uniform_f_array(global.uFlashColor, choose([0.8,0,0],[0.2,0.1,0]));
draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
gpu_set_colorwriteenable(1, 1, 1, 0);

var _radius = 10;

var _angle = point_direction(x, y, oPlayer.x, oPlayer.y);
var _drawX = sprite_xoffset + lengthdir_x(_radius, _angle) + random_range(-5, 5) * min(4, flash + bigFlash * 4);
var _drawY = sprite_yoffset + lengthdir_y(_radius, _angle) + random_range(-5, 5) * min(4, flash + bigFlash * 4);


var _col = make_color_hsv(random(255),255,255);
shader_set_uniform_f(global.uFlashColor, color_get_red(_col)/255, color_get_green(_col)/255, color_get_blue(_col)/255);
draw_sprite_ext(sLvl1BossIris, 0, _drawX, _drawY, 1+flash, 1+flash*2, _angle-180, c_white, 1);
shader_reset();
gpu_set_colorwriteenable(1, 1, 1, 1);
surface_reset_target();



// Set the bloom surface
shader_set(shFlash);
shader_set_uniform_f(global.uFlashColor, 1,1,1);
shader_set_uniform_f(global.uFlashPercent, bigFlash);

surface_set_target(oBloom.surfacePing);
camera_apply(view_camera[0]);

var _scale = 1 + flash * 0.2;
var _len = point_distance(0,0,sprite_xoffset,sprite_yoffset)*_scale;
var _dir = point_direction(sprite_xoffset,sprite_yoffset,0,0);
var _extra = random_range(-20,20) * flash;
draw_surface_ext(surf, x +lengthdir_x(_len, _dir+_extra), y +lengthdir_y(_len, _dir+_extra), image_xscale*_scale, image_yscale*_scale, image_angle+_extra, c_white, image_alpha);

shader_reset();