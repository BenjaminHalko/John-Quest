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
mouthBurnPercent = 0;
mouthYPercent = 0;
mouthY = 0;
openMouth = false;
createdFireball = false;
shotFireball = false;
mouthWait = 0;

// Eyes
instance_create_depth(x,y,depth-4,oBossLvl4Eyes);
shootEyes = false;
shootEyesPercent = 0;
eye1 = noone;
eye2 = noone;