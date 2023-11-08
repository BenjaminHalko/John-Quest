/// @desc 

enableLive;

if (global.audioTick) {
	timer--;
	
	if (global.audioBeat % beatLoop == beatOffset) {
		timer = length;
		flash = 1;
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
	y = Approach(y, ystart-distance, length * (abs(distance)/64));	
}

flash = ApproachFade(flash, 0, 0.1, 0.7);