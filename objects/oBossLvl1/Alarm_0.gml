/// @desc 

if (intro) {
	if (++introPhase > 5) {
		intro = false;
		oPlayer.autoMove = undefined;
	}
} else if (!dead) {
	inBetweenPhases = false;
	phase++;
}