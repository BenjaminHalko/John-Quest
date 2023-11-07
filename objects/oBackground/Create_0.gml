/// @desc 


particles = [];

for(var i = 0; i < 100; i++) {
	array_push(particles, {
		x: random(480),
		y: random(270),
		audioReactive: (irandom(3) == 0),
		spd: random(1),
		pulse: 0,
		beat: i % 4
	});
}