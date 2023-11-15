/// @desc 

enableLive;

flash = 0;
bigFlash = 0;

hp = 1500;
maxHp = hp;

phase = 0;
inBetweenPhases = false;
stunned = false;
explosionWait = 0;

dead = false;
movement = 0;
deadBeat = 0;
deadFlash = 0;

surf = -1;
lastTime = 1;
scale = 1;

panic = 0;
shootPulse = 0;

destroyCurve = animcurve_get_channel(BossLvl1Curves, "destroy");

tutorial = true;

eyes = [
	{ x: -42, y: 2, angle: 4 }, // 3
	{ x: -14, y: -44, angle: -7 }, // 1
	{ x: -9, y: 50, angle: 5 }, // 5
	{ x: -24, y: 24, angle: -2 }, // 4
	{ x: -29, y: -20, angle: -2 } // 2
];

for (var i = 0; i < 5; i++) {
	eyes[i].waveOffset = random(1);
	eyes[i].obj = instance_create_depth(x+eyes[i].x,y+eyes[i].y,depth-(5-i)*2,oBossLvl1Small);
	with(eyes[i].obj) {
		image_angle = other.eyes[i].angle;	
	}
}