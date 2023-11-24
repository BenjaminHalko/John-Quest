function ActivateBombNPC()
{
	if (!global.playerItemUnlocked[ITEM.BOMB]) {
		NewTextBox("Here, take this bomb.\nI hear it is dangerous to go without bombs.",2);
		oPlayer.lastState = PlayerStateGetItem;
	} else {
		NewTextBox("Legends has it, you can\npress [SHIFT] to swap items",2);
	}
}

function ActivateBombNPCItemGot() {
	NewTextBox("Legends has it, you can\npress [SHIFT] to swap items",2);
}