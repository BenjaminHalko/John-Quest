function UseItemSword() {
	//Attack Just Started
	if (animType != PLAYERANIM.SLASH)
	{
		animType = PLAYERANIM.SLASH;
	
		//Clear hit list
		if (!ds_exists(hitByAttack,ds_type_list)) hitByAttack = ds_list_create();
		ds_list_clear(hitByAttack);
	}

	CalcAttack(sPlayerAttackSlashHB);

	if(animationEnd)
	{
		state = PlayerStateFree;
		animationEnd = false;
	}
}

function UseItemBomb()
{
	if(global.playerBombAmmo > 0) and (global.iLifted == noone)
	{
		global.playerBombAmmo--;
		var _bomb = instance_create_layer(x,y,"Instances",oBomb);
		ActivateLiftable(_bomb);
	}
}

function UseItemHook()
{
	state = PlayerStateHook;
}