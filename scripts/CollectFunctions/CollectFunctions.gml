function CollectCoins(_amount)
{
	global.playerMoney += _amount;
	audio_play_sound(snCoin,1,false);
}

function CollectBomb(_amount)
{
	//_array = [type,amount]
	audio_play_sound(snCoin,1,false,1,0,0.5);
	global.playerBombAmmo += _amount;
}

function CollectHeart(_amount)
{
	//_array = [type,amount]
	audio_play_sound(snCoin,1,false,1,0,1.2);
	global.playerHealth = min(global.playerHealthMax,global.playerHealth+_amount);
}