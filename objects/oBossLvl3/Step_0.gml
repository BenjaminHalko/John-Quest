/// @desc 

enableLive;

if (global.my <= INVENTORY_Y) {
	var _hovered = false;
	
	if (!showingAnimation) {
		with(oBossLvl3Eye) {
			hovered = position_meeting(mouse_x,mouse_y,id);
			if (hovered) {
				if (global.clicked) {
					if (global.inHand == -1) {
						with(oInventory) {
							audio_stop_sound(talking);
							talking = audio_play_sound(snEyeTouch,1,false);
							subtitles = "Ouch! Aaaah the pain!\nThere must be a way to defeat it...";
						}
					} else {
						var _type = oInventory.inventory[global.inHand];
						switch(_type) {
							case INVENTORY.LIST: {
								with(oInventory) {
									audio_stop_sound(talking);
									talking = audio_play_sound(snAttemptList,1,false);
									subtitles = "What am I supposed to do with this?\nGive it paper cuts?";
								}
							} break;
							case INVENTORY.CANNON: case INVENTORY.PROPELLER: case INVENTORY.SHIP2: {
								with(oInventory) {
									audio_stop_sound(talking);
									talking = audio_play_sound(snAttemptList,1,false);
									subtitles = "I am supposed to be collecting these!\nNot giving them away...";
								}
							} break;
							default: {
								if (_type == INVENTORY.MONEY and other.type != 0) {
									with(oInventory) {
										audio_stop_sound(talking);
										talking = audio_play_sound(snAttemptMoney,1,false);
										subtitles = "I don't think bribing it with\nmoney would be of any help.";
									}
									break;
								}
								if (_type != INVENTORY.MONEY and other.type == 0) {
									with(oInventory) {
										audio_stop_sound(talking);
										talking = audio_play_sound(snAttemptMoney,1,false);
										subtitles = "Unfortunately, they seemed to have figured\nout that shopkeepers are immune to damage!!!";
									}
									break;
								}
							} break;
						}
					}
				}
				_hovered = true;
				break;
			}
		}
	}
	setCursor(_hovered ? CURSOR.HOVER : CURSOR.NORMAL);
}