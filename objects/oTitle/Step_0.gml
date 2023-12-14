 /// @desc 

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

if (music == -1) {
	if (!instance_exists(oTransition)) {
		music = audio_play_sound(mOpening,1,false);	
	}
} else if (title) {
	var _select = function() {
		audio_stop_sound(music);
		audio_play_sound(snItemGet, 1, false);
		allowInput = false;
		alarm[0] = blinkSpd;
	}
	if (allowInput) {
		blinkWave = Wave(0,2,0.5,0);
		if (menu == MENU.MAIN) {
			var _input = keyDown - keyUp;
			if (_input != 0) {
				if (menuPressedV != _input) {
					menuSelected = Wrap(menuSelected+_input,lastLevel == -1,3);
					menuPressedV = _input;
					audio_play_sound(snBlip,1,false);
				}
			} else {
				menuPressedV = 0;
			}
			
			if (keyAction) {
				if (menuSelected == 2) {
					menu = MENU.LEVELSELECT;
					menuSelected = 0;
					audio_play_sound(snBlip,1,false);
				} else if (menuSelected == 3) {
					menu = MENU.CREDITS;
					audio_play_sound(snBlip,1,false);
				} else if (menuSelected == 1 and lastLevel != -1) {
					menu = MENU.NEWGAME;
					menuSelected = 1;
					audio_play_sound(snBlip,1,false);
				} else {
					_select();	
				}
			}
		} else if (menu == MENU.LEVELSELECT) {
			var _hInput = keyRight - keyLeft;
			var _vInput = keyDown - keyUp;
			if (_hInput != 0) {
				if (menuPressedH != _hInput) {
					if (menuSelected == 0) menuSelected = 1+(_hInput == 1);
					else menuSelected = (menuSelected - 1 + (menuSelected % 2)*2);
					menuPressedH = _hInput;
					audio_play_sound(snBlip,1,false);
				}
			} else {
				menuPressedH = 0;	
			}
			if (_vInput != 0) {
				if (menuPressedV != _vInput) {
					if (menuSelected == 0 and _vInput == 1) menuSelected = 1;
					else {
						menuSelected += _vInput * 2;
						if (menuSelected == -1 or menuSelected > 8) menuSelected = 0;
						else if (menuSelected < 0) menuSelected = 7;
					}
					audio_play_sound(snBlip,1,false);
					menuPressedV = _vInput;
				}
			} else {
				menuPressedV = 0;
			}
			
			if (keyAction) {
				if (menuSelected == 0) {
					menu = MENU.MAIN;
					menuSelected = 2;
					audio_play_sound(snBlip,1,false);
				} else _select();
			}
		} else if (menu == MENU.NEWGAME) {
			var _input = keyDown - keyUp;
			if (_input != 0) {
				if (menuPressedV != _input) {
					menuSelected = 1 - menuSelected;
					menuPressedV = _input;
					audio_play_sound(snBlip,1,false);
				}
			} else {
				menuPressedV = 0;
			}
			
			if (keyAction) {
				if (menuSelected == 0) _select();
				else {
					menu = MENU.MAIN;
					menuSelected = 1;
					audio_play_sound(snBlip,1,false);
				}
			}
		} else if (keyAction) {
			menu = MENU.MAIN;
			audio_play_sound(snBlip,1,false);
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
		} else if (menu == MENU.NEWGAME) {
			file_delete(SAVEFILE);
			Transition(rLvl1);
		} else {
			global.noSave = true;
			ini_open(SAVEFILE);
			ini_section_delete("lvl1_temp");
			ini_section_delete("lvl2_temp");
			ini_section_delete("lvl3_temp");
			ini_section_delete("lvl4_temp");
			ini_close();
			
			if (menuSelected <= 2) Transition(rLvl1);
			else if (menuSelected <= 4) Transition(rLvl2);
			else if (menuSelected == 5) Transition(rLvl3);
			else Transition(rLvl4);
			
			global.atBoss = (menuSelected == 2 or menuSelected == 4 or menuSelected == 7);
			if (menuSelected == 8) global.atBoss = 2;
		}
	}
} else {
	if (keyAction or !audio_is_playing(mOpening)) {
		title = true;
		moveUpPercent = 1;
		audio_stop_sound(music);
		music = audio_play_sound(mTitle,1,true);
	} else if (textNum < 5) {
		var _target = (textNum == textTarget);
		textAlpha = Approach(textAlpha, _target, 0.03);

		if (textAlpha == _target) {
			if (_target == 0) {
				textNum++;
				wait = 264;
			} else if (--wait <= 0) {
				textTarget++;
			}
		}
		startUpPos = audio_sound_get_track_position(music);
	} else {
		var _pos = audio_sound_get_track_position(music);
		moveUpPercent = animcurve_channel_evaluate(moveUpCurve,min(1,(_pos-startUpPos)/(musicLength-startUpPos)));
	}
	blend = clamp((moveUpPercent-0.5)*2,0,1);
	if (blend != 0) layer_background_blend(layer_background_get_id("Background"),merge_color(#240F38,c_black,blend));
}
	