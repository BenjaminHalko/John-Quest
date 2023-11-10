/// @desc 

repeat(20) {
	with(instance_create_depth(x+random_range(-6,6),y+random_range(-6,6),depth-1,oTriangleParticle)) {
		image_blend = #99005A;
		direction = random(360);
		speed = random(3);
		spd = random_range(0.02, 0.1);
		radius = 4;
	}
}

ScreenShake(3, 2);
other.hurtPlayer();

instance_destroy();