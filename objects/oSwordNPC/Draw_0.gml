/// @desc 

enableLive;

// Inherit the parent event
event_inherited();

if (global.questStatusHat == 2) {
	draw_sprite_ext(sHat,0,floor(x-2*image_xscale),floor(y-24-z),image_xscale,1,0,c_white,1);
}