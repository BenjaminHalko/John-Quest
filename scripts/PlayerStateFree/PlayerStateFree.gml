function PlayerStateFree() {
	//Movement
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	PlayerCollision();
	
	if (inputMagnitude != 0) {
		animType = PLAYERANIM.RUN;
		direction = inputDirection;
	} else {
		animType = PLAYERANIM.IDLE;
	}
	
	PlayerAnimateSprite();

	//Activate Key Logic
	if (keyAction)
	{
		//1. Check for an entity to activate
		//2. If there is nothing, or there is somehing but it has no script
			//2A. If we are carrying something, throw it!
			//2B. Otherwise, roll!
		//3. Otherwise, there is something and it has a script! Activate!
		//4. If the thing we activate is an NPC, make it face towards us!
	
		var _activateX = x;
		var _activateY = y;
		var _activateSize = 10;
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
			} else {
				// Attack	
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
		var _cycleDirection = keyItemSelectUp - keyItemSelectDown;
		if(_cycleDirection != 0)
		{
			do
			{
				global.playerEquipped += _cycleDirection;
				if(global.playerEquipped < 1) global.playerEquipped = ITEM.TYPE_COUNT-1;
				if(global.playerEquipped >= ITEM.TYPE_COUNT) global.playerEquipped = 1;
			}
			until (global.playerItemUnlocked[global.playerEquipped]);
		}
	}
}