/// @desc 

enableLive;

flash = 0;
bigFlash = 0;

hp = 2000;
maxHp = hp;

phase = 0;
inBetweenPhases = false;

surf = -1;

eyes = [
	{ x: -14, y: -44, angle: -7 },
	{ x: -29, y: -20, angle: -2 },
	{ x: -42, y: 2, angle: 4 },
	{ x: -24, y: 24, angle: -2 },
	{ x: -9, y: 50, angle: 5 }
];

for (var i = 0; i < 5; i++) {
	eyes[i].waveOffset = random(1);
	eyes[i].obj = instance_create_layer(x+eyes[i].x,y+eyes[i].y,layer,oLvl1BossSmall);
	with(eyes[i].obj) {
		image_angle = other.eyes[i].angle;	
	}
}