/// @desc 

if (global.inHand != -1) {
	if (global.clicked) {
		if (inventory[global.inHand] != INVENTORY.LIST or global.isBattle) {
			itemX = global.mx;
			itemY = global.my;
		} else {
			itemX = 240;
			itemY = INVENTORY_Y/2+16;
		}
		itemReturn = global.inHand;
		itemReturnPercent = 0;
		global.inHand = -1;
	}
	if (global.my > INVENTORY_Y) setCursor(CURSOR.NORMAL);
} else if (global.my > INVENTORY_Y) {
	waitY = 15;
	var _hovering = false;
	if (global.allowInput) {
		for(var i = 0; i < inventorySlots; i++) {
			if (inventory[i] == -1 or i == global.inHand) continue;
		
			var _x = 480/2 + (width - 32)/(inventorySlots-1)*(i-(inventorySlots-1)/2);
		
			if (point_in_rectangle(global.mx,global.my,_x-24,inventoryY-48,_x+24,inventoryY)) {
				_hovering = true;
				if (global.clicked) {
					if (inventory[i] == INVENTORY.LIST) {
						global.inHand = i;
					} else {
						var _node = global.nodes[global.currentNode];
						if (global.isBattle) {
							global.inHand = i;
						} else {
							audio_stop_sound(talking);
							talking = audio_play_sound(dialog[inventory[i]].audio,1,false);
							subtitles = dialog[inventory[i]].subtitles;
						}
					}
				}
			}
		}
	}
	
	setCursor(_hovering ? CURSOR.HOVER : CURSOR.NORMAL);
}

if (itemReturn != -1 and !stopReturn) {
	itemReturnPercent = ApproachFade(itemReturnPercent,1,0.2,0.6);
	if (itemReturnPercent == 1) itemReturn = -1;
}

var _target = (global.my > INVENTORY_Y or global.inHand != -1 or itemReturn != -1 or audio_is_playing(talking) or global.isBattle);
if _target waitY = 20;
else _target = (--waitY > 0);

if (instance_exists(oTransition)) _target = 0;

for(var i = 0; i < 5; i++) {
	if (i == 0 or (_target ? (inventoryItemY[i-1] > 0.4) : (inventoryItemY[i-1] < 0.6))) {
		inventoryItemY[i] = Approach(inventoryItemY[i],_target,0.1);
	}
}