/// @desc 

enableLive;

enum INVENTORY {
	MONEY,
	SWORD,
	BOMB,
	SHIP0,
	SHIP1,
	SHIP2
}

global.inHand = -1;
inventory = array_create(5, -1);
inventory[0] = INVENTORY.BOMB;
inventory[1] = INVENTORY.SWORD;
inventory[2] = INVENTORY.MONEY;
width = 360;
inventoryY = 256;

inventoryItemY = array_create(5,0);
inventoryYCurve = animcurve_get_channel(InventoryCurves,"appear");

waveOffsets = [
	0.5,
	0.3,
	0.7,
	0.2,
	0.9
]

// Return item
itemReturn = -1;
itemX = -1;
itemY = -1;
itemReturnPercent = 1;