/// @desc 

enableLive;

if (oLvl1Boss.inBetweenPhases) {
	image_alpha -= 0.05;
	if (image_alpha <= 0) {
		instance_destroy();	
	}
} else {
	if (global.audioTick) {
		counter--;
		if (counter == 0) {
			with(instance_create_layer(x,y,layer,oLvl1BossShock)) {
				targetYscale = other.image_yscale;
				image_angle = other.image_angle;
				fade = other.id;
				spikeDir = other.spikeDir;
			}
		}
	}
	image_alpha += 0.005;
}