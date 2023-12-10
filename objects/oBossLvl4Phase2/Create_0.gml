/// @desc 

enableLive;

event_inherited();

oCamera.xOffset = -80;

x = oPlayer.x - 700;
y = oPlayer.y;

stepPercent = 0;
fall = false;
stepWait = 0;
yStepTarget = y - 20;
yStepBegin = y;

// temp
instance_destroy(oBigRock);