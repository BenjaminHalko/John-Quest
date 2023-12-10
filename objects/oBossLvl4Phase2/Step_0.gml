/// @desc 

enableLive;

event_inherited();

// Stepping
if (fall) {
	stepPercent = Approach(stepPercent,0,0.1);
	if (stepPercent == 0) {
		ScreenShake(5,15);
		fall = false;
		stepWait = 30;
		yStepBegin = y-30;
	}
	//x += 2;
} else if (--stepWait <= 0 and step) {
	stepPercent = Approach(stepPercent,1,0.02);
	if (stepPercent == 1) {
		yStepTarget = oCamera.y+20;
		fall = true;
	}
	//x += 1.5;
}
y = lerp(yStepTarget,yStepBegin,stepPercent);

// Mouth Fireball
if (keyboard_check_pressed(ord("M"))) openMouth = !openMouth; 
mouthYPercent = ApproachFade(mouthYPercent,openMouth,0.1,0.7);
mouthY = mouthYPercent * 64;

// Kill Player
if (oPlayer.x < x) {
	oPlayer.hp = 0;
	oPlayer.allowMovement = false;
}

if (place_meeting(x,y,oPlayer) and oPlayer.hurt > 0) {
	oPlayer.hsp = oPlayer.movespd;	
}