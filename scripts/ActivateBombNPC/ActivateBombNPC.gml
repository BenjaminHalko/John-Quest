function ActivateBombNPC()
{
	if (!global.playerItemUnlocked[ITEM.BOMB]) {
		NewTextBox("Here, take this bomb.\nI hear it is dangerous to go without bombs.",2);
		oPlayer.lastState = PlayerStateGetItem;
	} else {
		if (global.playerBombAmmo == 0) {
			if (global.ranOutOfBombs == 0) {
				NewTextBox("You used up all my precious bombs!!!\nI am so sad.\nLuckily, I have a few more...",2);
				global.playerBombAmmo = 10;
			} else if (global.ranOutOfBombs == 1) {
				NewTextBox("Again??? Are you wasting my\nbombs on purpose?!?\nI still have a few more...",2);
				global.playerBombAmmo = 20;
			} else if (global.ranOutOfBombs == 2) {
				NewTextBox("Why are you doing this...\nHere, take my entire stock! If you run\nout after this, I am not helping anymore.",2);
				global.playerBombAmmo = 50;
			} else if (global.ranOutOfBombs == 3) {
				NewTextBox("R.I.P. Bomb Dude\nHe died very confused.",0);
				instance_create_layer(oBombNPC.x,oBombNPC.y,"Instances",oExplode);
				instance_destroy(oBombNPC);
			}
			global.ranOutOfBombs++;
		} else if (global.ranOutOfBombs == 3) {
			NewTextBox("...why?",2);
		} else if (global.ranOutOfBombs == 2) {
			NewTextBox("I'm watching you...",2);
		} else if (global.ranOutOfBombs == 1) {
			NewTextBox("Be more careful next time.",2);
		} else {
			NewTextBox("Word of advice:\nDon't go wasting your bombs,\nyou only have a limited number.",2);
		}
	}
}

function ActivateBombNPCItemGot() {
	NewTextBox("Legends has it, you can\npress [SHIFT] to swap items.",2);
}