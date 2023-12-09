/// @desc 

if (global.my <= INVENTORY_Y) {
	if (position_meeting(mouse_x,mouse_y,id)) {
		hovered = true;
		if (global.clicked) {
			var _requiredItem = [
				INVENTORY.SWORD,
				INVENTORY.BOMB,
				-1
			];
			
			if (global.inHand == _requiredItem[type]) {
				// Collect item
				var _index = ((type+1)%3)+1;
				global.inHand = -1;
				with(oInventory) {
					inventory[_index] = other.type + INVENTORY.PROPELLER;
					itemX = other.x;
					itemY = other.y;
					itemReturn = _index;
					itemReturnPercent = 0;
				}
				audio_play_sound(snItemGet,1,false,0.6);
				Save("lvl3",$"item{type}",true);
				global.piecesCollected[type] = true;
				audio_stop_sound(oNodeController.music);
				if (array_equals(global.piecesCollected, [1,1,1])) {
					global.allowInput = false;
					call_later(60, time_source_units_frames, function() {
						global.introLvl3 = true;
						Transition(rLvl3Intro);	
					});
				} else {
					global.isBattle = false;
					var _music = [mLvl3Music,mLvl3Music2,mLvl3Music3];
					var _amount = 0;
					for(var i = 0; i < 3; i++) {
						_amount += global.piecesCollected[i];	
					}
					oNodeController.music = audio_play_sound(_music[min(2,_amount)],1,true);
				}
				global.clicked = false;
				instance_destroy();
			} else {
				var _audio = [
					(global.inHand == -1) ? snAttemptTakePropellers : snAttemptRepair,
					(global.inHand == -1) ? snAttemptTakeCannon : snAttemptLoad,
					snAttemptCombine
				];
				var _subtitles = [
					(global.inHand == -1) ? "The propellers need to be\nrepaired before I can take them." : "I don't think I can\nrepair them with that.",
					(global.inHand == -1) ? "The cannon needs to be loaded\nbefore I can take it." : "I don't think I can use\nthat to load the cannon.",
					"I don't think I can\ncombine those together."
				];
				with(oInventory) {
					audio_stop_sound(talking);
					talking = audio_play_sound(_audio[other.type],1,false);
					subtitles = _subtitles[other.type];
				}
			}
		}
	} else {
		hovered = false;	
	}
	setCursor(hovered ? CURSOR.HOVER : CURSOR.NORMAL);
}

scale = ApproachFade(scale,1,0.1,0.7);
image_xscale = scale;
image_yscale = scale;