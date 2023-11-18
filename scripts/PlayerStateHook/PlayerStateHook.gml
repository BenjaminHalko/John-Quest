function PlayerStateHook()
{
	hSpeed = 0;
	vSpeed = 0;
	
	//If just arriving in this state
	if (animType != PLAYERANIM.HOOK)
	{
		hook = 0;
		hookX = 0;
		hookY = 0;
		hookStatus = HOOKSTATUS.EXTENDING;
		hookedEntity = noone;
		
		//Update Sprite
		animType = PLAYERANIM.HOOK;
	}
	
	PlayerAnimateSprite();
	
	//Extend/Retract Hook
	var _speedHookTemp = speedHook;
	if (hookStatus != HOOKSTATUS.EXTENDING) _speedHookTemp *= -1;
	hook += _speedHookTemp;
	switch(direction div 90)
	{
		case 0: hookX = hook; break;
		case 1: hookY = -hook; break;
		case 2: hookX = -hook; break;
		case 3: hookY = hook; break;
	}
	
	//Hookshot State Machine!
	switch(hookStatus)
	{
		case HOOKSTATUS.EXTENDING:
		{
			//Finish Extending
			if(hook >= distanceHook) hookStatus = HOOKSTATUS.MISSED;
			
			//Check for a hit
			var _hookHit = collision_circle(x+hookX,y+hookY,4,pEntity,false,true);
			if(_hookHit != noone) and (global.iLifted != _hookHit)
			{
				//Act depending on what is hit
				switch(_hookHit.entityHookable)
				{
					default: //Not Hookable Entity
					{
						//...else potententially harm enemy
						if(object_is_ancestor(_hookHit.object_index,pEnemy))
						{
							HurtEnemy(_hookHit,1,id,5);
							hookStatus = HOOKSTATUS.MISSED;
						}
						else
						{
							if(_hookHit.entityHitScript != -1)
							{
								with(_hookHit) script_execute(entityHitScript);
								hookStatus = HOOKSTATUS.MISSED;
							}
						}
					} break;
					case 1:
					{
						hookStatus = HOOKSTATUS.PULLTOPLAYER;
						hookedEntity = _hookHit;
					} break;
					case 2:
					{
						hookStatus = HOOKSTATUS.PULLTOENTITY;
						hookedEntity = _hookHit;
					} break;
				}
			}
		} break;
		
		//Pull the Entity towards the hooked player
		case HOOKSTATUS.PULLTOPLAYER:
		{
			with (hookedEntity)
			{
				x = other.x+other.hookX;
				y = other.y+other.hookY;
			}
		} break;
		
		//Pull the player towards the hooked entity
		case HOOKSTATUS.PULLTOENTITY:
		{
			switch (direction div 90)
			{
				case 0: x += speedHook; break;
				case 1: y -= speedHook; break;
				case 2: x -= speedHook; break;
				case 3: y += speedHook; break;
			}
		} break;
	}
	
	//Finish retract and end state
	if(hook <= 0)
	{
		if (hookedEntity.entityActivateScript == ActivateLiftable) {
			ScriptExecuteArray(ActivateLiftable,hookedEntity.entityActivateArgs);
		}
		hookedEntity = noone;
		state = PlayerStateFree;
	}
}