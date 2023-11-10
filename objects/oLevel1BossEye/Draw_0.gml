/// @description Insert description here
// You can write your code in this editor

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
gpu_set_colorwriteenable(1, 1, 1, 0);

var radius = 10;

var draw_x = 0;
var draw_y = 0;


var angle = point_direction(x, y, oPlayer.x, oPlayer.y);
draw_x = lengthdir_x(radius, angle);
draw_y = lengthdir_y(radius, angle);

	draw_sprite(sLvl1BossEyeNormalIris, 0, draw_x, draw_y);
	gpu_set_colorwriteenable(1, 1, 1, 1);
	surface_reset_target();
	draw_surface(surf, x - sprite_xoffset, y - sprite_yoffset);