global.gamePaused = false;
global.textSpeed = .75;
global.targetRoom = -1;
global.targetX = -1;
global.targetY = -1;
global.targetDirection = 0;
global.playerHealthMax = 3;
global.playerHealth = global.playerHealthMax;
global.playerMoney = 0;

//Items
global.playerHasAnyItems = false;
global.playerEquipped = ITEM.SWORD;
global.playerAmmo = array_create(ITEM.TYPE_COUNT,-1);
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);

global.iLifted = noone;
global.iUI = instance_create_layer(0,0,layer,oUI);