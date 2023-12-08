/// @desc 

repeat(50) {
	with(instance_create_depth(x+random_range(-8,8),y+random_range(-8,8),depth-1,oTriangleParticle)) {
		radius = 7;
		speed = random(4);
		spd = 0.04;
		direction = random(360);
		image_angle = random(360);
	}
	
}

ScreenShake(5,3);
audio_play_sound(snExplosionShort,1,false,0.5);