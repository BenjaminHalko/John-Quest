/// @desc 

event_inherited();

oCamera.xOffset = -50;

x = 2944-820;
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
mouthOpenWait = 60/150*6*4;

// Eyes
instance_create_depth(x,y,depth-4,oBossLvl4Eyes);
shootEyes = false;
shootEyesPercent = 0;
eye1 = noone;
eye2 = noone;
shootEyesWait = -1;

// Intro
intro = true;

// Outro
noAttackX = 12000;
stopX = 12940;
stopMouthX = stopX-16;

dead = false;
deadPercent = 0;
deadWait = 60;

// Music
music = audio_play_sound(mLvl4MusicBoss2,1,true,1,60/150*2*4);
audio_sound_loop_start(music, 60/150*8*4);