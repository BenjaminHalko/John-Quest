function CollectCoins(_amount)
{
	global.playerMoney += _amount;
}

function CollectBomb(_amount)
{
	//_array = [type,amount]
	global.playerBombAmmo += _amount;
}