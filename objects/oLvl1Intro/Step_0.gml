/// @desc 

enableLive;

var _time = oMusicController.thisBeat % 0.25;

if (counter > 0) {
	if (_time < lastTime) {
		counter--;
	}
	lastTime = _time;
} else {
	playerY = Approach(playerY, oPlayer.y, 64);
	if (playerY == oPlayer.y) {
		for(var i = 0; i < array_length(layersToHide); i++) {
			layer_set_visible(layersToHide[i], true);
		}
		instance_destroy();
		oPlayer.yscale = 2;
		oPlayer.autoMove = undefined;
	}
}