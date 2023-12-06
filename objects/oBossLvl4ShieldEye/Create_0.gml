/// @desc 

// Inherit the parent event
event_inherited();

size = sprite_get_width(sprite_index);
surf = surface_create(size,size);
xOffset = sprite_get_xoffset(sprite_index);
yOffset = sprite_get_yoffset(sprite_index);
lastFocusX = 0;
lastFocusY = 0;
focusX = 0;
focusY = 0;
focusPercent = 0;
focusTimer = 0;
focusIsOnPlayer = false;

waveOffset = random(1);