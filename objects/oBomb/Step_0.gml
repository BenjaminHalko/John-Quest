/// @desc

if (global.iLifted == id and bombStage == -1) bombStage = 0;
if(!global.gamePaused and bombStage >= 0)
{
	bombTick--;
	if(bombTick == 0)
	{
		flash = 0.75;
		bombStage++;
		bombTick = bombTickRate[bombStage];
		
		if(bombTick < 0)
		{
			y -= z;
			if(lifted)
			{
				with(oPlayer)
				{
					PlayerDropItem();
				}
			}
			instance_destroy();
		}
	}
}