/// @desc 

for(var i = 0; i < array_length(particles); i++) {
	particles[i].y -= particles[i].spd;
	if (particles[i].y < -5) {
		particles[i].x = random(480);
		particles[i].y = 275;
		particles[i].audioReactive = (irandom(9) == 0);
		particles[i].spd = random_range(0.02, 1);
	}
}