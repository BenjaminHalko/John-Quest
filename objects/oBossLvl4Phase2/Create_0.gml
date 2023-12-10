/// @desc 

enableLive;

event_inherited();

oCamera.xOffset = -80;

x = oPlayer.x -300//- 700;
y = oPlayer.y;


// Step
step = false;
stepPercent = 0;
fall = false;
stepWait = 0;
yStepTarget = y - 20;
yStepBegin = y;

// Mouth
instance_create_depth(x,y,depth-2,oBossLvl4Mouth);
fireball = noone;
mouthYPercent = 0;
mouthY = 0;
openMouth = false;
createdFireball = false;
shotFireball = false;
mouthWait = 0;

// Eyes
shootEyes = false;
eye1 = noone;
eye2 = noone;