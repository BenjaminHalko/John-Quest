/// @desc 

if (!surface_exists(surf)) surf = surface_create(sprite_width, sprite_height);
flash = Approach(flash, 0, 0.1);

if (place_meeting(x,y,oPlayer) and !oBossLvl1.inBetweenPhases) {
	oPlayer.hurtPlayer();
	oPlayer.hsp = -10;
}