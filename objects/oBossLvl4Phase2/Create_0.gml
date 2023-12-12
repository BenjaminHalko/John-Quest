/// @desc 

enableLive;

event_inherited();

oCamera.xOffset = -50;

//x = 2944-820;
y = oPlayer.y;

instance_destroy(oCameraBoundary);


// Step
step = true;
stepPercent = 0;
fall = false;
stepWait = 0;
yStepTarget = y - 20;
yStepBegin = y;
stepCounter = 0;

// Mouth
instance_create_depth(x,y,depth-2,oBossLvl4Mouth);
fireball = noone;
mouthBurnPercent = 0;
mouthYPercent = 0;
mouthY = 0;
openMouth = false;
createdFireball = false;
shotFireball = false;
mouthWait = 0;
mouthOpenWait = 60*3;

// Eyes
instance_create_depth(x,y,depth-4,oBossLvl4Eyes);
shootEyes = false;
shootEyesPercent = 0;
eye1 = noone;
eye2 = noone;
shootEyesWait = -1;

// Intro
intro = false;

// Outro
noAttackX = 12000;
stopX = 12940;

dead = false;
deadPercent = 0;
deadWait = 120;