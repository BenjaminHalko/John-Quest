function ActivateBombNPC()
{
	if (!global.playerItemUnlocked[ITEM.BOMB]) {
		NewTextBox("lvl2.bomb.preitem",2);
		oPlayer.lastState = PlayerStateGetItem;
	} else {
		if (global.playerBombAmmo == 0) {
			if (global.ranOutOfBombs == 0) {
				NewTextBox("lvl2.bomb.refill.0",2);
				global.playerBombAmmo = 20;
			} else if (global.ranOutOfBombs == 1) {
				NewTextBox("lvl2.bomb.refill.1",2);
				global.playerBombAmmo = 30;
			} else if (global.ranOutOfBombs == 2) {
				NewTextBox("lvl2.bomb.refill.2",2);
				global.playerBombAmmo = 50;
			} else if (global.ranOutOfBombs == 3) {
				NewTextBox("lvl2.bomb.refill.3",0);
				instance_create_layer(oBombNPC.x,oBombNPC.y,"Instances",oExplode);
				instance_destroy(oBombNPC);
			}
			global.ranOutOfBombs++;
		} else if (global.ranOutOfBombs == 3) {
			NewTextBox("lvl2.bomb.advice.3",2);
		} else if (global.ranOutOfBombs == 2) {
			NewTextBox("lvl2.bomb.advice.2",2);
		} else if (global.ranOutOfBombs == 1) {
			NewTextBox("lvl2.bomb.advice.1",2);
		} else {
			NewTextBox("lvl2.bomb.advice.0",2);
		}
	}
}

function ActivateBombNPCItemGot() {
	NewTextBox("lvl2.bomb.postitem0",2);
	NewTextBox("lvl2.bomb.postitem1",2);
	NewTextBox("lvl2.bomb.postitem2",2);
}