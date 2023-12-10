/// @desc 

// Inherit the parent event
event_inherited();

scale = 1;
spd = 0;
dir = 0;
size = sprite_get_width(sprite_index);
surf = surface_create(size,size);
xOffset = sprite_get_xoffset(sprite_index);
yOffset = sprite_get_yoffset(sprite_index);
lastFocusX = 0;
lastFocusY = 0;
focusPercent = 1;
focusTimer = 30;
focusIsOnPlayer = true;
var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
focusX = lengthdir_x(16,_dir);
focusY = lengthdir_y(16,_dir);

waveOffset = random(1);
explode = false;
red = false;