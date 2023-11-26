/// @desc 

// Inherit the parent event
event_inherited();

if (global.questStatusHat == 2) {
	draw_sprite(sHat,0,floor(x),floor(y-sprite_height+10-z));
}