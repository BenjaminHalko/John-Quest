/// @desc 

// Inherit the parent event
event_inherited();

var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
x += lengthdir_x(1,_dir);
y += lengthdir_y(1,_dir);