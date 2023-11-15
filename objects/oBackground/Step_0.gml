/// @desc 

enableLive;

for(var i = 0; i < array_length(particles); i++) {
	particles[i].y -= lerp(1, 4, particles[i].spd) * (1-bossTransitionPercent);
	particles[i].x -= lerp(15, 20, particles[i].spd) * bossTransitionPercent * lerp(0.2, 1, finalSpd);
	
	if (global.audioTick and particles[i].audioReactive and global.audioBeat % 4 == particles[i].beat and !bossMode) {
		particles[i].pulse = 6;
	}
	particles[i].pulse = ApproachFade(particles[i].pulse, 0, 0.2, 0.7);
	if (particles[i].y < -30) {
		particles[i].x = random(480);
		particles[i].y = 300;
		particles[i].audioReactive = (irandom(2) == 0);
		particles[i].spd = random(1);
	}
	
	if (particles[i].x < -30 and finalSpd == 1) {
		particles[i].x = 590;
		particles[i].y = random(270);
		particles[i].audioReactive = false;
		particles[i].spd = random(1);
	}
}

bossTransitionPercent = ApproachFade(bossTransitionPercent, bossMode, 0.05, 0.7);