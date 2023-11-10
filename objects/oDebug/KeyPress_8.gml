/// @desc 

currentCheckpoint = min(14, currentCheckpoint+1);

if (currentCheckpoint < 14) {
	saveData(true);
}

with(oCheckpoint) {
	if (scale == 1 and other.currentCheckpoint != 14 and checkpointNumber == other.currentCheckpoint) or (scale == -1 and other.currentCheckpoint == 14 and checkpointNumber == 13)	{
		oPlayer.x = x+sprite_width/2;
		oPlayer.y = y+sprite_height-8;
		
		oCamera.x = oPlayer.x;
		oCamera.y = oPlayer.y;
		oCamera.xTo = oCamera.x;
		oCamera.yTo = oCamera.y;
		oCamera.boundry = noone;
	}
}