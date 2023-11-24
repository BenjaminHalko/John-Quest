ini_open(SAVEFILE);

global.gamePaused = false;
global.textSpeed = .75;
global.playerHealthMax = 3;
global.playerHealth = global.playerHealthMax;
global.playerMoney = Load("lvl2","money",0,false);
global.saveX = Load("lvl2","x",-1,false);
global.saveY = Load("lvl2","y",-1,false);
global.saveDir = Load("lvl2","dir",270,false);

// Items
global.playerEquipped = Load("lvl2","equipped",ITEM.SWORD,false);
global.playerBombAmmo = Load("lvl2","bombAmmo",10,false);
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);
global.playerItemUnlocked[ITEM.SWORD] = Load("lvl2","unlockedSword",false,false);
global.playerItemUnlocked[ITEM.BOMB] = Load("lvl2","unlockedBomb",false,false);
global.playerHasAnyItems = !array_equals(global.playerItemUnlocked, array_create(ITEM.TYPE_COUNT, false));

global.iLifted = noone;
global.iUI = instance_create_layer(0,0,layer,oUI);

// Collision
layer_set_visible("Walls", false);

// Quest Status
global.questStatusHat = Load("lvl2","questHat",0,false);

// Close file
ini_close();