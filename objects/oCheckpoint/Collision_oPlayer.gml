if(oPlayer.respawnPercent == 1) {
	oPlayer.respawnX = x+sprite_width/2;
	oPlayer.respawnScale = scale;
	oPlayer.respawnY = y+sprite_height-8;
	
	with (oDebug) {
		if (other.scale == -1 and other.checkpointNumber == currentCheckpoint) {
			currentCheckpoint++;
			saveData();
		}
	}
}