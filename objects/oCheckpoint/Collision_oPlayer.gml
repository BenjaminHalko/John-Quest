if(oPlayer.respawnPercent == 1) {
	oPlayer.respawnX = x;
	oPlayer.respawnScale = scale;
	oPlayer.respawnY = y-16;
	
	instance_destroy();
}