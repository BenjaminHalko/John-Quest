/// @desc 

enum TRANSITION {
	SQUARES,
	SPIRAL,
	FADE
}

leading = true;
transitionSpd = 0.05;
switch (roomTo) {
	case rLvl1: default: {
		transitionType = TRANSITION.SQUARES;
	} break;
	case rLvl2: {
		transitionType = TRANSITION.SPIRAL;
		size = 30;
		distance = 0;
		var _heightLeft = 270;
		var _widthLeft = 480 - size;
		while(_widthLeft > 0 and _heightLeft > 0) {
			distance += _widthLeft + _heightLeft;
			_widthLeft -= 30;
			_heightLeft -= 30;
		}
		transitionSpd = 0.02;
	} break;
	case rLvl4: {
		if (roomTo == rLvl4) transitionType = TRANSITION.FADE;
		else transitionType = TRANSITION.SQUARES;
	} break;
	case rCredits: {
		transitionType = TRANSITION.FADE;
		transitionSpd = 0.02;
	} break;
	case rTitle: {
		transitionType = TRANSITION.FADE;
	} break;
}

behindPlayer = false;
if (instance_exists(oPlayer) and (room == rLvl1 and roomTo == rLvl2)) {
	depth = oPlayer.depth + 1;
	behindPlayer = true;
}

global.atBoss = false;