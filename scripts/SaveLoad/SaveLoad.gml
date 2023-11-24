#macro SAVEFILE "save.ini"
function Save(_section, _key, _value, _openFile=true) {
	if (!global.noSave) {
		if (_openFile) ini_open(SAVEFILE);
		ini_write_real(_section, _key, _value);
		if (_openFile) ini_close();
	}
}

function Load(_section, _key, _default, _openFile=true) {
	if (global.noSave) return _default;
	if (_openFile) ini_open(SAVEFILE);
	var _value = ini_read_real(_section, _key, _default);
	if (_openFile) ini_close();
	return _value;
}

function SaveLvl2() {
	ini_open(SAVEFILE);
	Save("lvl2","x",global.saveX,false);
	Save("lvl2","y",global.saveY,false);
	Save("lvl2","dir",global.saveDir,false);
	Save("lvl2","money",global.playerMoney,false);
	Save("lvl2","equipped",global.playerEquipped,false);
	Save("lvl2","bombAmmo",global.playerBombAmmo,false);	
	Save("lvl2","unlockedSword",global.playerItemUnlocked[ITEM.SWORD],false);
	Save("lvl2","unlockedBomb",global.playerItemUnlocked[ITEM.BOMB],false);
	ini_close();
}