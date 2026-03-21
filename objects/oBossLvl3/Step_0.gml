/// @desc 

if (global.my <= INVENTORY_Y) {
	var _hovered = false;
	
	if (!showingAnimation) {
		with(oBossLvl3Eye) {
			if (position_meeting(mouse_x,mouse_y,id)) {
                hovered = 1;
                _hovered = true;
            }
			if (hovered > 0) {
				if (global.clicked) {
					if (global.inHand == -1) {
						with(oInventory) {
							audio_stop_sound(talking);
							talking = audio_play_sound(snEyeTouch,1,false);
							subtitles = lexicon_text("lvl3.eyeInteract.touch");
						}
					} else {
						var _type = oInventory.inventory[global.inHand];
						switch(_type) {
							case INVENTORY.LIST: {
								with(oInventory) {
									audio_stop_sound(talking);
									talking = audio_play_sound(snAttemptList,1,false);
									subtitles = lexicon_text("lvl3.eyeInteract.useList");
								}
							} break;
							case INVENTORY.CANNON: case INVENTORY.PROPELLER: case INVENTORY.LASER: {
								with(oInventory) {
									audio_stop_sound(talking);
									talking = audio_play_sound(snAttemptPart,1,false);
									subtitles = lexicon_text("lvl3.eyeInteract.usePickup");
								}
							} break;
							default: {
								if (_type == INVENTORY.MONEY and other.type != 2) {
									with(oInventory) {
										audio_stop_sound(talking);
										talking = audio_play_sound(snAttemptMoney,1,false);
										subtitles = lexicon_text("lvl3.eyeInteract.useMoney");
									}
									break;
								}
								if (_type != INVENTORY.MONEY and other.type == 2) {
									with(oInventory) {
										audio_stop_sound(talking);
										talking = audio_play_sound(snAttemptDamage,1,false);
										subtitles = lexicon_text("lvl3.eyeInteract.useWeapon");
									}
									break;
								}
								other.showingAnimation = true;
								dead = true;
								type = _type;
								depth--;
							} break;
						}
					}
				}
				break;
			}
		}
	}
	setCursor(_hovered ? CURSOR.HOVER : CURSOR.NORMAL);
}

global.allowInput = !showingAnimation;

if (!instance_exists(oBossLvl3Eye)) {
	global.allowInput = true;
	instance_create_layer(room_width/2,room_height/2-20,layer,oItemLvl3);
	instance_destroy();
}