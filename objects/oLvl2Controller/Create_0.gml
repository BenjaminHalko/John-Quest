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
global.playerHasAnyItems = true;
global.playerEquipped = ITEM.BOMB;
global.playerBombAmmo = 10;
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, true);

global.iLifted = noone;
global.iUI = instance_create_layer(0,0,layer,oUI);

// Collision
layer_set_visible("Walls", false);