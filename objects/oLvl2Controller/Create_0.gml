ini_open(SAVEFILE);

global.gamePaused = false;
global.textSpeed = .75;
global.playerHealthMax = 3;
global.playerHealth = global.playerHealthMax;
global.playerMoney = ini_read_real("lvl2","money",0);
global.saveX = ini_read_real("lvl2","x",-1);
global.saveY = ini_read_real("lvl2","y",-1);
global.saveDir = ini_read_real("lvl2","dir",270);

// Items
global.playerEquipped = ini_read_real("lvl2","equipped",ITEM.SWORD);
global.playerBombAmmo = ini_read_real("lvl2","bombAmmo",10);
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);
global.playerItemUnlocked[ITEM.SWORD] = ini_read_real("lvl2","unlockedSword",false);
global.playerItemUnlocked[ITEM.BOMB] = ini_read_real("lvl2","unlockedBomb",false);

// tmp
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, true);			

global.playerHasAnyItems = !array_equals(global.playerItemUnlocked, array_create(ITEM.TYPE_COUNT, false));
ini_close();


global.iLifted = noone;
global.iUI = instance_create_layer(0,0,layer,oUI);

// Collision
layer_set_visible("Walls", false);