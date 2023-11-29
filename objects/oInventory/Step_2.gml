/// @desc 

enableLive;

if (global.inHand != -1) {
	if (global.clicked) {
		itemX = global.mx;
		itemY = global.my;
		itemReturn = global.inHand;
		itemReturnPercent = 0;
		global.inHand = -1;
	}
	setCursor(CURSOR.NORMAL);
} else if (global.my > INVENTORY_Y) {
	var _hovering = false;
	for(var i = 0; i < 5; i++) {
		if (inventory[i] == -1) continue;
		
		var _x = 480/2 + (width - 32)/4*(i-2);
		
		if (point_in_rectangle(global.mx,global.my,_x-24,inventoryY-48,_x+24,inventoryY)) {
			_hovering = true;
			if (global.clicked) {
				global.inHand = i;	
			}
		}
	}
	
	setCursor(_hovering ? CURSOR.HOVER : CURSOR.NORMAL);
}

if (itemReturn != -1) {
	itemReturnPercent = ApproachFade(itemReturnPercent,1,0.2,0.6);
	if (itemReturnPercent == 1) itemReturn = -1;
}

var _target = (global.my > INVENTORY_Y or global.inHand != -1 or itemReturnPercent < 0.95);
for(var i = 0; i < 5; i++) {
	if (i == 0 or (_target ? (inventoryItemY[i-1] > 0.4) : (inventoryItemY[i-1] < 0.6))) {
		inventoryItemY[i] = Approach(inventoryItemY[i],_target,0.1);
	}
}