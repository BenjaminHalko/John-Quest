/// @desc 




image_xscale = ApproachFade(image_xscale,1,0.15,0.7);
image_yscale = image_xscale;

if (image_xscale == 1 and --wait <= 0) {
	y = Approach(y,oPlayer.y,spd);
	spd += 0.2;
	
	if (y == oPlayer.y) {
		oPlayer.flash = 1;
		oPlayer.flashCol = [1,1,1];
		global.playerItemUnlocked[gotSword ? ITEM.SWORD : ITEM.BOMB] = true;
		global.playerHasAnyItems = true;
		global.saveDir = 270;
		SaveLvl2();
		audio_play_sound(snItemGet, 1, false);
		instance_destroy();
	}
} else {
	y = Wave(ystart-6,ystart+6,1.5,0);
}





//done

