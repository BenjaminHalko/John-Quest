function PlayerAnimateSprite() {
	if (live_call()) return live_result;
	
	var _changedAnim = (lastAnim != animType);
	lastAnim = animType;
	if (animType == PLAYERANIM.IDLE or animType == PLAYERANIM.RUN) {
		var _movement = (animType == PLAYERANIM.RUN);
		if (_movement) walkWave += 1/10;
		var _lift = (global.iLifted != noone);
		yscale = ApproachFade(yscale,1-min(1, (abs(hSpeed) + abs(vSpeed))/speedWalk)*lerp(0.05,0.4,0.5+sin(walkWave*pi)/2/(1 + _lift)) - 0.22 * _lift,0.23,0.7);
		xscale = 1/(yscale + 0.1	 * _lift);
		topShift = ApproachFade(topShift, lengthdir_x(speedWalk, inputDirection) * _movement, 0.5, 0.7);
	} else if (animType == PLAYERANIM.LIFT) {
		if (_changedAnim) {
			liftAnimPercent = 0;
		}
		liftAnimPercent = Approach(liftAnimPercent, 1, 0.2);
		yscale = ApproachFade(yscale, 1 - 0.8 * liftAnimPercent, 0.5, 0.5);
		xscale = ApproachFade(xscale, 1 + 0.5 * liftAnimPercent, 0.5, 0.5);
		if (liftAnimPercent == 1) animationEnd = true;
	}
}