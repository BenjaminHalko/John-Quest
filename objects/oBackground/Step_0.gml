/// @desc 

for(var i = 0; i < array_length(particles); i++) {
	particles[i].y -= lerp(1, 4, particles[i].spd);
	if (global.audioTick and particles[i].audioReactive and global.audioBeat % 4 == particles[i].beat) {
		particles[i].pulse = 3;
	}
	particles[i].pulse = ApproachFade(particles[i].pulse, 0, 0.1, 0.7);
	if (particles[i].y < -20) {
		particles[i].x = random(480);
		particles[i].y = 290;
		particles[i].audioReactive = (irandom(4) == 0);
		particles[i].spd = random(1);
	}
}