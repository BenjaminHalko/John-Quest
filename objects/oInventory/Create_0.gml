/// @desc 

enableLive;

enum INVENTORY {
	LIST,
	MONEY,
	SWORD,
	BOMB,
	PROPELLER,
	CANNON,
	SHIP2
}

inventorySlots = 4;
global.inHand = -1;
inventory = [
	INVENTORY.LIST,
	INVENTORY.MONEY,
	INVENTORY.SWORD,
	INVENTORY.BOMB
];
isDraggable = false;
width = 300;
inventoryY = 256;

waitY = 0;
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
stopReturn = false;

// Speech
dialog = [];
dialog[INVENTORY.SWORD] = {audio: snSwordDesc, subtitles: "It is my trusty sword."};
dialog[INVENTORY.BOMB] = {audio: snBombDesc, subtitles: "It's a bomb! Very explosive!"};
dialog[INVENTORY.MONEY] = {audio: snCoinDesc, subtitles: "That's all the coins I collected\nfrom those evil monsters!"};
dialog[INVENTORY.PROPELLER] = {audio: snPropellerDesc, subtitles: "It's the propeller I repaired with my sword."};
dialog[INVENTORY.CANNON] = {audio: snCannonDesc, subtitles: "The cannon is loaded with explosive bombs!"};
dialog[INVENTORY.SHIP2] = {audio: snCoinDesc, subtitles: "???"};
talking = -1;
subtitles = "";

// Item width / height
var _number = sprite_get_number(sInventoryItems);
itemWidth = array_create(_number);
itemHeight = array_create(_number);
for(var i = 0; i < _number; i++) {
	itemWidth[i] = texture_get_texel_width(sprite_get_texture(sInventoryItems, i));
	itemHeight[i] = texture_get_texel_height(sprite_get_texture(sInventoryItems, i));
}

// Collected items
itemListDesc = [
	"propeller\nblades",
	"explosive\ncannon",
	"???"
];

if (global.piecesCollected[2]) inventory[0] = INVENTORY.SHIP2;
if (global.piecesCollected[0]) inventory[1] = INVENTORY.PROPELLER;
if (global.piecesCollected[1]) inventory[2] = INVENTORY.CANNON;