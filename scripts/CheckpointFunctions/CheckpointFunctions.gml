function SaveLvl2() {
	ini_open(SAVEFILE);
	ini_write_real("lvl2","x",global.saveX);
	ini_write_real("lvl2","y",global.saveY);
	ini_write_real("lvl2","dir",global.saveDir);
	ini_write_real("lvl2","money",global.playerMoney);
	ini_write_real("lvl2","equipped",global.playerEquipped);
	ini_write_real("lvl2","bombAmmo",global.playerBombAmmo);	
	ini_write_real("lvl2","unlockedSword",global.playerItemUnlocked[ITEM.SWORD]);
	ini_write_real("lvl2","unlockedBomb",global.playerItemUnlocked[ITEM.BOMB]);
	ini_close();
}