/// @description Insert description here
// You can write your code in this editor
if (!surface_exists(surf))
{
	surf = surface_create(sprite_width, sprite_height);
}

surface_set_target(surf);
draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
gpu_set_colorwriteenable(1, 1, 1, 1);

var radius = 10;
var player = instance_nearest(x, y, oPlayer)

var draw_x = 0;
var draw_y = 0;

if (player != noone)
{
    var angle = point_direction(x, y, player.x, player.y);
	
    var newX = lengthdir_x(5, angle);
    var newY = lengthdir_y(5, angle);
	draw_x = newX;
    draw_y = newY;
}

	draw_sprite(sLvl1BossEyeNormalIris, 0, draw_x, draw_y);
	gpu_set_colorwriteenable(1, 1, 1, 1);
	surface_reset_target();
	draw_surface(surf, x - sprite_xoffset, y - sprite_yoffset);