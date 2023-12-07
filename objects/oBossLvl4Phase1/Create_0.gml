/// @desc 

enableLive;
event_inherited();

enum BOSSLVL4 {
	HOMING,
	HEXAGON,
	CHARGE,
	SPINCYCLE,
	BULLETHELL,
	CHASE,
	DVD
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
actualLastAttack = -1;
tempNoAttack = true;

// Hexagon
hexagonLastStart = -1;
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

// Spin Cycle
spinCyclePercent = 0;
spinCycleSwitchPercent = 0;

// DVD
dvdShootTimer = 0;
dvdShootDir = 0;

// Movement
spd = 0;
dir = 0;
targetX = 0;
targetY = 0;

var _boundary = oCamera.boundary;
if (_boundary != noone) {
	bLeft = _boundary.bbox_left+32;
	bRight = _boundary.bbox_right-32;
	bTop = _boundary.bbox_top+32;
	bBottom = _boundary.bbox_bottom-32;
	bCenterX = (bLeft+bRight)/2;
	bCenterY = (bTop+bBottom)/2;
}

// Eyes
repeat(6) {
	array_push(eyes,instance_create_depth(x,y,depth+1,oBossLvl4ShieldEye));
}