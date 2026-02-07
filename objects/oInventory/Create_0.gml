/// @desc 

enum INVENTORY {
	LIST,
	MONEY,
	SWORD,
	BOMB,
	PROPELLER,
	CANNON,
	LASER
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
dialog[INVENTORY.SWORD] = {audio: snSwordDesc, subtitles: lexicon_text("lvl3.desc.sword")};
dialog[INVENTORY.BOMB] = {audio: snBombDesc, subtitles: lexicon_text("lvl3.desc.bomb")};
dialog[INVENTORY.MONEY] = {audio: snCoinDesc, subtitles: lexicon_text("lvl3.desc.coin")};
dialog[INVENTORY.PROPELLER] = {audio: snPropellerDesc, subtitles: lexicon_text("lvl3.desc.propeller")};
dialog[INVENTORY.CANNON] = {audio: snCannonDesc, subtitles: lexicon_text("lvl3.desc.cannon")};
dialog[INVENTORY.LASER] = {audio: snLaserDesc, subtitles: lexicon_text("lvl3.desc.laser")};
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
	lexicon_text("lvl3.listItem.propeller"),
	lexicon_text("lvl3.listItem.cannon"),
	lexicon_text("lvl3.listItem.laser")
];

if (global.piecesCollected[2]) inventory[1] = INVENTORY.LASER;
if (global.piecesCollected[0]) inventory[2] = INVENTORY.PROPELLER;
if (global.piecesCollected[1]) inventory[3] = INVENTORY.CANNON;