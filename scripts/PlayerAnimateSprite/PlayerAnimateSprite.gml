function PlayerAnimateSprite() {
	if (live_call()) return live_result;
	
	var _changedAnim = (lastAnim != animType);
	lastAnim = animType;
	switch(animType) {
		case PLAYERANIM.IDLE: case PLAYERANIM.RUN: {
			var _movement = (animType == PLAYERANIM.RUN);
			if (_movement) walkWave += 1/10;
			var _lift = (global.iLifted != noone);
			yscale = ApproachFade(yscale,1-min(1, (abs(hSpeed) + abs(vSpeed))/speedWalk)*lerp(0.05,0.4,0.5+sin(walkWave*pi)/2/(1 + _lift)) - 0.22 * _lift,0.23,0.7);
			xscale = 1/(yscale + 0.1 * _lift);
			topShift = ApproachFade(topShift, lengthdir_x(speedWalk, inputDirection) * _movement, 0.5, 0.7);
			topShiftY = ApproachFade(topShiftY, 0, 6, 0.3);
		} break;
		case PLAYERANIM.LIFT: {
			if (_changedAnim) animPercent = 0;
			animPercent = Approach(animPercent, 1, 0.2);
			yscale = ApproachFade(yscale, 1 - 0.8 * animPercent, 0.5, 0.5);
			xscale = ApproachFade(xscale, 1 + 0.5 * animPercent, 0.5, 0.5);
			if (animPercent == 1) animationEnd = true;
		} break;
		case PLAYERANIM.SLASH: {
			if (_changedAnim) animPercent = 0;
			animPercent = Approach(animPercent, 1, 0.08);
			yscale = ApproachFade(yscale, 1, 0.3, 0.6);
			xscale = 1/yscale;
			var _realPercent = animcurve_channel_evaluate(swordCurve, animPercent)
			topShift = lengthdir_x(5, direction) * _realPercent;
			topShiftY = lengthdir_y(5, direction) * _realPercent;
			if (animPercent == 1) animationEnd = true;
		} break;
	}
}