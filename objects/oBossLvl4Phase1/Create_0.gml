/// @desc 

enableLive;
event_inherited();

enum BOSSLVL4 {
	HOMING,
	HEXAGON,
	CHARGE,
	BULLETHELL
}

scale = 1;
angle = 0;

maxHp = hp;

timer = 0;

eyes = [];
eyeRotation = 0;
eyeRotationSpd = 1;
eyeDist = 28;
manageShield = true;

// Stun Percent
stunned = false;
stunPercent = 0;
stunParticleRotation = 0;

// Attack
attack = -1;
lastAttack = -1;

// Hexagon
hexagonPercent = 0;
hexagons = [];
hexagonCurve = animcurve_get_channel(BossLvl4Curves,"hexagon");

// Charge
chargePercent = 0;
chargeDir = 0;
chargeSpd = 0;

// Homing
homingPercent = 0;
homingCount = 0;

repeat(6) {
	array_push(eyes,instance_create_depth(x,y,depth+1,oBossLvl4ShieldEye));
}