/// @desc 


particles = [];

repeat(100) {
	array_push(particles, {
		x: random(480),
		y: random(270),
		audioReactive: (irandom(9) == 0),
		spd: random_range(0.02, 1),
		paralax: random_range(0.01, 1),
		pulse: 0
	});
}