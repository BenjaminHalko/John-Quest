/// @desc 

event_inherited();

maxHp = enemyHP;

isTeleporting = false;

eyeSpinRotationDir = 1;
eyeSpinRotation = 0;
eyeExpandPercent = 0;
teleportMovementSpd = 3;
teleportAppearWait = 0;
teleportAppear = false;
changeLocation = false;

disappearPercent = 0;
surf = surface_create(sprite_width,sprite_height);

eyeExpandCurve = animcurve_get_channel(BossLvl2Curves, "eyeExpand");

yEyeOffset = 40;

intro = true;
introWait = 60;

isShooting = false;
shootPercent = 0;
shootCounter = 0;

dead = false;
deadPercent = 0;
deadPhase = 0;
deadWait = 30;

shouldDie = false;
zSpeed = 0;
zSpeedAccel = 0;

eyes = [
	{ x: 0, y: 2, waveOffset: 0.9},
	{ x: -7, y: -1, waveOffset: 0.2 },
	{ x: 6, y: -1, waveOffset: 0.5 },
	{ x: -4, y: -5, waveOffset: 0.3 },
	{ x: 3, y: -5, waveOffset: 0.7 }
];
for(var i = 0; i < 5; i++) {
	eyes[i].obj = instance_create_layer(0,0,layer,oBossLvl2Eye);
}

eyeX = x;
eyeY = y;
newX = x;
newY = y;

if (intro) {
	eyeExpandPercent = 1;
	disappearPercent = 1.5;
	teleportAppear = true;
}