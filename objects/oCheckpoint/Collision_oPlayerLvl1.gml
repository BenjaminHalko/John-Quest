if(oPlayer.respawnPercent == 1) {
	if (oPlayer.respawnX != x+sprite_width/2 or oPlayer.respawnY != y+sprite_height-8) {
		oPlayer.respawnX = x+sprite_width/2;
		oPlayer.respawnScale = dir;
		oPlayer.respawnY = y+sprite_height-8;
		
		Save("lvl1","saveDir",dir);
		Save("lvl1","saveNumber",checkpointNumber);
	}
}