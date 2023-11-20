function UseItemSword() {
	state = PlayerStateSword;
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