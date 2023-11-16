/// @desc 

if (counter <= 0) {
	baseScale = Approach(baseScale, 0, 0.2);
	if (baseScale <= 0.2) instance_destroy();
}

flash = Approach(flash, 0, 0.15);
image_xscale = baseScale + flash * 0.5;
image_yscale = image_xscale;

if (--waitTimer <= 0) {
	waitTimer = 4;
	if (!created and x-24 >= oCamera.x - oCamera.viewWidthHalf and !oBossLvl1.inBetweenPhases) {
		created = true;
		with(instance_create_layer(x-18,y,layer,oBossLvl1Snake)) {
			counter = other.counter;
		}
	}
	counter--;
}