function CalcAttack()
{
	var hitByAttackNow = ds_list_create();
	var hits = instance_place_list(x,y,pEntity,hitByAttackNow,false);
	if(hits > 0)
	{
		for(var i = 0; i < hits; i++)
		{
			//If this instance has not yet been hit by this attack, hit it
			var hitID = hitByAttackNow[| i];
			if(ds_list_find_index(oPlayer.hitByAttack, hitID) == -1)
			{
				ds_list_add(oPlayer.hitByAttack,hitID);
				with(hitID)
				{
					if (object_is_ancestor(object_index, pEnemy))
					{
						HurtEnemy(id, 5, other.id, 10);
					}
					else if (entityHitScript != -1) script_execute(entityHitScript);
				}
			}
		}
	}
	ds_list_destroy(hitByAttackNow);
}

function HurtEnemy(_enemy, _damage, _source, _knockback)
{
	with (_enemy)
	{
		if (state != ENEMYSTATE.DIE)
		{
			if (enemyAttackable) {
				enemyHP -= _damage;
				flash = 1;
				flashCol = [1,1,1];
			
				//Hurt or Dead
				if(enemyHP <= 0)
				{
					state = ENEMYSTATE.DIE;
				}
				else
				{
					if (state != ENEMYSTATE.HURT) statePrevious = state;
					state = ENEMYSTATE.HURT;
				}
			
				image_index = 0;
				if (_knockback != 0)
				{
					var _knockDirection = point_direction(x,y,_source.x,_source.y);
					xTo = x - lengthdir_x(_knockback,_knockDirection);
					yTo = y - lengthdir_y(_knockback,_knockDirection);
				}
			} else {
				flash = 0.5;
				flashCol = [0.5,0,1];
			}
		} 
	}
}