/// @desc 

currentCheckpoint = min(14, currentCheckpoint+1);

if (currentCheckpoint < 14) {
	saveData(true);
}

with(oCheckpoint) {
	if (scale == 1 and other.currentCheckpoint == checkpointNumber)	{
		oPlayer.x = x+sprite_width/2;
		oPlayer.y = y+sprite_height-8;
		
		oCamera.snapToFollow();
		oCamera.boundary = noone;
	}
}