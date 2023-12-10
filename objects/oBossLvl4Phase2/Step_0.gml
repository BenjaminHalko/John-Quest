/// @desc 

enableLive;

event_inherited();

if (fall) {
	stepPercent = Approach(stepPercent,0,0.1);
	if (stepPercent == 0) {
		ScreenShake(5,15);
		fall = false;
		stepWait = 30;
		yStepBegin = y-30;
	}
	x += 2;
} else if (--stepWait <= 0) {
	stepPercent = Approach(stepPercent,1,0.02);
	if (stepPercent == 1) {
		yStepTarget = oCamera.y+30;
		fall = true;
	}
	x += 1.5;
}


if (place_meeting(x,y,oPlayer) and oPlayer.hurt > 0) {
	oPlayer.hsp = oPlayer.movespd;	
}
y = lerp(yStepTarget,yStepBegin,stepPercent);

if (oPlayer.x < x) {
	oPlayer.hp = 0;
	oPlayer.allowMovement = false;
}