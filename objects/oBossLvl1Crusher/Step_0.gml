/// @desc 

enableLive;

if (remove or oBossLvl1.inBetweenPhases) {
	image_yscale = Approach(image_yscale, 0, 4);
	if (image_yscale == 0) instance_destroy();
} else if (!crush) {
	image_yscale += 0.1;
	
	if (global.audioTick) {
		if (--counter <= 0) {
			crush = true;
			flash = 1;
			instance_destroy(fade);
			counter = 2;
			ScreenShake(5,5);
		}
	}
} else {
	image_yscale = Approach(image_yscale, targetYscale, 3);
	
	if (global.audioTick) {
		if (--counter <= 0) {
			remove = true;
		}
	}
}

var _len = abs(image_yscale * 8);
x = xstart + lengthdir_x(_len, image_angle-90);
y = ystart + lengthdir_y(_len, image_angle-90);
flash = Approach(flash, 0, 0.05);