/// @desc 

enableLive;

if (moveUpPercent > 0.1) {
	for(var i = 0; i < array_length(stars); i++) {
		stars[i].alpha += stars[i].spd;
		if (stars[i].alpha >= 2) {
			stars[i].x = irandom(480);	
			stars[i].y = irandom(270);
			stars[i].spd = random_range(0.001,0.01);
			stars[i].alpha = 0;
		}
	}
}

if (title) {
	
} else {
	if (textNum < 5) {
		var _target = (textNum == textTarget);
		textAlpha = Approach(textAlpha, _target, 0.03);

		if (textAlpha == _target) {
			if (_target == 0) {
				textNum++;
				wait = 210;
			} else if (--wait <= 0) {
				textTarget++;
			}
		}
	} else if (moveUpPercent == 1) {
		if (--wait <= 0) title = true;
	} else {
		moveUpSpd = Approach(moveUpSpd, 0.004, 0.00005);
		moveUpPercent = Approach(moveUpPercent, 1, moveUpSpd);
		if moveUpPercent == 1 wait = 30;
	}
}
	