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
dead = false;

timer = 0;

eyes = [];
eyeRotation = 30;
eyeRotationSpd = 1;
eyeDist = 28;
manageShield = true;

// Stun Percent
stunned = false;
stunPercent = 0;
stunParticleRotation = 0;

// Attack
attack = BOSSLVL4.CHARGE;
lastAttack = -1;
actualLastAttack = -1;

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

// Dead
mushroomY = 0;
explosionCount = 0;
maxExplosions = 16;
vSpd = 0;

var _boundary = oCamera.boundary;
bLeft = _boundary.bbox_left+32;
bRight = _boundary.bbox_right-32;
bTop = _boundary.bbox_top+32;
bBottom = _boundary.bbox_bottom-32;
bCenterX = (bLeft+bRight)/2;
bCenterY = (bTop+bBottom)/2;
x = bCenterX;
y = bCenterY;

// Intro
intro = true;
introPhase = -1;
image_blend = c_black;
eyeDist = 0;
introPercent = 0;


// Eyes
repeat(6) {
	array_push(eyes,instance_create_depth(x,y,depth+1,oBossLvl4ShieldEye));
}