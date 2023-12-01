/// @desc 

enableLive;

Input();

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
	var _select = function() {
		allowInput = false;
		alarm[0] = blinkSpd;
	}
	if (allowInput) {
		blinkWave = Wave(0,2,0.5,0);
		if (menu == MENU.MAIN) {
			var _input = keyDown - keyUp;
			if (_input != 0) {
				if (!menuPressed) {
					menuSelected = Wrap(menuSelected+_input,lastLevel == -1,3);
					menuPressed = true;
				}
			} else {
				menuPressed = false;
			}
			
			if (keyAction) {
				if (menuSelected == 2) {
					menu = MENU.LEVELSELECT;	
				} else if (menuSelected == 3) {
					menu = MENU.CREDITS;	
				} else {
					_select();	
				}
			}
		} else if (menu == MENU.LEVELSELECT) {
				
		} else {
			
		}
	} else if (blink > 12) {
		if (menu == MENU.MAIN) {
			if (menuSelected == 0) {
				var _levels = [rLvl1,rLvl2,rLvl3,rLvl4];
				Transition(_levels[lastLevel]);
			} else {
				file_delete(SAVEFILE);
				Transition(rLvl1);
			}
		} else {
			global.noSave = true;
		}
	}
} else {
	if (keyAction) {
		title = true;	
	}
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
	