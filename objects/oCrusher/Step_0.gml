/// @desc 

if (image_index == 1) exit;

if (length > 0) {
    if (global.audioTick) {
    	timer--;
    	
    	if (global.audioBeat % beatLoop == beatOffset) {
    		timer = length;
    		flash = 1;
            windUp = 0;
    	} else if (
            (global.audioBeat+1) % beatLoop == beatOffset
            or (global.audioBeat+2) % beatLoop == beatOffset
        ) {
    		windUp++
    	}
    } 
} else {
    if (instance_exists(oPlayerLvl1) and oPlayerLvl1.x > x + 96) {
        if (timer <= 0) {
            timer = 1;
            flash = 1;
            windUp = 0;
        }
    } else {
        timer = 0;
    }
}


if (timer > 0) {
	if (y != ystart) {
		y = Approach(y, ystart, 20 * ((abs(distance)+48)/64));
		if (y == ystart and isOnScreen()) {
			ScreenShake(3,7);	
		}
	}
} else {
    if (windUp > 0) {
        y = ApproachFade(y, ystart-distance-sign(distance) * 24 * windUp, 6, 0.8);	
    } else if (length <= 0) {
        var _beat = abs(2 -(global.audioBeat + beatOffset) % 4);
        y = ApproachFade(y, ystart-distance+sign(distance) * 24 * _beat, 6, 0.8);	
    } else {
        y = Approach(y, ystart-distance, length * (abs(distance)/64));
    }
	
}

flash = ApproachFade(flash, 0, 0.1, 0.7);

extra.y = extra.ystart + (y - ystart);
extra.flash = flash;