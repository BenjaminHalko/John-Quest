/// @desc

hsp = 0;
vsp = 0;
hsp_f = 0;
vsp_f = 0;
hsp_final = 0;
vsp_final = 0;

moveSpd = 4;
grv = 0.5;
jumpSpd = -9;
topShiftPercent = 1;
rotation = 0;

isDashing = false;
dash = 0;
dashSpd = 15;

dance = 0;

allowDash = false;

doubleJump = 0;
canJump = 0;
savedJumpID = noone;
jumpTimer = 0;

dirFacing = 1;

wHalf = sprite_width/2;

xscale = 1;
yscale = 1;

diagLen = point_distance(0,0,wHalf,wHalf);

flash = 0;

walkWave = 0;

respawnPercent = 1;
respawnX = x;
respawnY = y;
respawnScale = 1;

hurt = 0;
autoMove = undefined;

tempHurt = 0;

hurtPlayer = function() {
	if(respawnPercent == 1) {
		xstart = x;
		ystart = y;
		hsp = 0;
		vsp = -7;
		hsp_final = 0;
		vsp_final = 0;
		dash = 0;
		respawnPercent = -1;
		allowDash = true;
		audio_play_sound(snPlayerDie,1,false);
	}	
}