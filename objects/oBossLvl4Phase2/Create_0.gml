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
mouthYPercent = 0;
mouthY = 0;
openMouth = false;

// Fireball

// temp
instance_destroy(oBigRock);