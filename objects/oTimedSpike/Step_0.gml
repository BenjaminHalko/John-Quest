/// @desc 

if (global.audioTick) {
	timer--;
	if (timer <= 0) {
		instance_destroy(spike);
		image_alpha = 1;
		image_index = 0;
	}
	
	if (global.audioBeat % 4 == beatOffset and !instance_exists(oIntroLvl1)) {
		spike = instance_create_depth(x,y,depth+1,oSpike);
		with(spike) {
			image_angle = other.image_angle;
			image_xscale = other.image_xscale;
			image_yscale = other.image_yscale;
		}
		timer = length;
		image_index = 1
	}
}

if (timer > 0) {
	image_alpha = ApproachFade(image_alpha, 0, 0.08, 0.7);	
}
