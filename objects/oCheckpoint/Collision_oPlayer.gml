if(oPlayer.respawnPercent == 1) {
	oPlayer.respawnX = x+sprite_width/2;
	oPlayer.respawnScale = scale;
	oPlayer.respawnY = y+sprite_height-16;
	
	instance_destroy();
}