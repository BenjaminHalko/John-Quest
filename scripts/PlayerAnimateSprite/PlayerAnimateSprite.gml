function PlayerAnimateSprite() {
	if (live_call()) return live_result;
	
	var _changedAnim = (lastAnim != animType);
	lastAnim = animType;
	if (animType == PLAYERANIM.IDLE or animType == PLAYERANIM.RUN) {
		var _movement = (animType == PLAYERANIM.RUN);
		if (_movement) walkWave += 1/10;
		yscale = ApproachFade(yscale,1-min(1, (abs(hSpeed) + abs(vSpeed))/speedWalk)*lerp(0.05,0.4,0.5+sin(walkWave*pi)/2),0.23,0.7);
		xscale = 1/yscale;
		topShift = ApproachFade(topShift, lengthdir_x(speedWalk, inputDirection) * _movement, 0.5, 0.7);
	} else if (animType == PLAYERANIM.LIFT) {
		if (_changedAnim) xscale = 0.5;
		xscale = ApproachFade(xscale, 1, 0.5, 0.7);
	}
}