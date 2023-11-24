function PlayerStateGetItem() {
	if (animType != PLAYERANIM.GETITEM) {
		animType = PLAYERANIM.GETITEM;
		direction = 270;
		grav = 0;
		animTimer = 30;
		if (global.playerItemUnlocked[ITEM.SWORD]) {
			global.saveX = 4720;
			global.saveY = 2408;
		} else {
			global.saveX = 2224;
			global.saveY = 3016;
		}
		instance_create_depth(oPlayer.x,oPlayer.y,-100000,oGetItem);
	}
	
	if (!instance_exists(oGetItem) and --animTimer <= 0) {
		if (animTimer == 0) grav = 5;
		if (grav > 0 or z != 0) {
			grav -= 0.5;
			z = max(0,z+grav);
			if (z == 0) {
				if (global.playerItemUnlocked[ITEM.BOMB]) {
					ActivateBombNPCItemGot();
				} else {
					ActivateSwordNPCItemGot();
				}
				lastState = PlayerStateFree;
			}
		}
	}
	
	PlayerAnimateSprite();
}