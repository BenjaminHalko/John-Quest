function CollectCoins(_amount)
{
	global.playerMoney += _amount;
	audio_play_sound(snCoin,1,false,1,0,random_range(0.8,1));
}

function CollectBomb(_amount)
{
	//_array = [type,amount]
	audio_play_sound(snCoin,1,false,1,0,random_range(0.5,0.7));
	global.playerBombAmmo += _amount;
}