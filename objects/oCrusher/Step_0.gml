/// @desc 

enableLive;

if (global.audioTick) {
	timer--;
	
	show_debug_message(global.audioBeat % 4);
	
	if (global.audioBeat % beatLoop == beatOffset) {
		timer = length;
	}
}

if (timer > 0) {
	if (y != ystart) {
		y = Approach(y, ystart, 20);
		if (y == ystart and isOnScreen()) {
			ScreenShake(5,10);	
		}
	}
} else {
	y = Approach(y, ystart-distance, 1);	
}