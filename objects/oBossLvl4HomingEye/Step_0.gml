/// @desc 

enableLive;

if (waitPercent == 1) {
	if (dirPercent != 1) {
		targetDir = point_direction(x,y,targetX,targetY);
	}
	dirPercent = Approach(dirPercent,1,0.05);
} else {
	targetX = oPlayer.x;
	targetY = oPlayer.y;
	targetDir = point_direction(x,y,targetX,targetY);
	waitPercent = Approach(waitPercent,1,0.05);
}

spd = animcurve_channel_evaluate(curve,(waitPercent+dirPercent)/2) * 6;
dir = moveDir - angle_difference(moveDir, targetDir) * dirPercent;

// Inherit the parent event
event_inherited();