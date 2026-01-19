function PlayerStateFree() {
	//Movement
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	PlayerCollision();
	
	if (hSpeed != 0 or vSpeed != 0) {
		animType = PLAYERANIM.RUN;
		direction = inputDirection;
	} else {
		animType = PLAYERANIM.IDLE;
	}
	
	PlayerAnimateSprite();

	//Activate Key Logic
	if (InputPressed(INPUT_VERB.ATTACK))
	{
		var _activateX = x;
		var _activateY = y;
		var _activateSize = 16;
		var _activateList = ds_list_create();
		activate = noone;
		var _entitiesFound = collision_rectangle_list(_activateX-_activateSize,_activateY-_activateSize,_activateX+_activateSize,_activateY+_activateSize,pEntity,false,true,_activateList,true);
	
	
		//If the first instance we find is either our lifted entity or it has no script: try the next one
		for(var i = 0; i < _entitiesFound; i++)
		{
			var _check = _activateList[| i];
			if (_check != global.iLifted) and (_check.entityActivateScript != -1)
			{
				activate = _check;
				break;
			}
		}
	
		ds_list_destroy(_activateList);
	
		if(activate == noone) {
			if(global.iLifted != noone) {
				PlayerThrow();
			} else if (global.playerHasAnyItems) {
				switch(global.playerEquipped) {
					case ITEM.SWORD: {
						UseItemSword();
					} break;
					case ITEM.HOOK: {
						UseItemHook();
					} break;
					case ITEM.BOMB: {
						UseItemBomb();
					} break;
				}
				
			}
		} else if (activate.entityActivateScript == ActivateLiftable and global.iLifted != noone) {
			PlayerThrow();
		} else {
			//Activate Entity
			ScriptExecuteArray(activate.entityActivateScript, activate.entityActivateArgs);
		}
	}
	
	//Cycle Items
	if(global.playerHasAnyItems)
	{
		if(InputPressed(INPUT_VERB.SWITCH))
		{
			var _start = global.playerEquipped;
			do
			{
				global.playerEquipped += 1;
				if(global.playerEquipped < 0) global.playerEquipped = ITEM.TYPE_COUNT-1;
				if(global.playerEquipped >= ITEM.TYPE_COUNT) global.playerEquipped = 0;
			}
			until (global.playerItemUnlocked[global.playerEquipped]);
			if (global.playerEquipped != _start) audio_play_sound(snBlip,1,false);
		}
	}
}