/// @description Insert description here
// You can write your code in this editor

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
gpu_set_colorwriteenable(1, 1, 1, 0);

var _radius = 10;

var _angle = point_direction(x, y, oPlayer.x, oPlayer.y);
var _drawX = lengthdir_x(_radius, _angle);
var _drawY = lengthdir_y(_radius, _angle);

draw_sprite(sLvl1BossEyeNormalIris, 0, _drawX, _drawY);
gpu_set_colorwriteenable(1, 1, 1, 1);
surface_reset_target();
draw_surface(surf, x - sprite_xoffset, y - sprite_yoffset);