/// @desc

if (activated) {
	ScreenShake(1.5,1);
	spd = Approach(spd,0.15,0.002);
	image_xscale = ApproachFade(image_xscale,0,spd,0.7);
	if (image_xscale == 0) instance_destroy();
}