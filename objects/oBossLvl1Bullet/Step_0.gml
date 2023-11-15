image_angle -= 30;

if (oBossLvl1.inBetweenPhases) {
	image_xscale = Approach(image_xscale, 0, 0.1);	
	image_yscale = image_xscale;
}