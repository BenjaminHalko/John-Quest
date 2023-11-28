/// @desc Execute State Machine
if(!global.gamePaused and z == 0)
{
	if (enemyScript[state] != -1) script_execute(enemyScript[state]);
	depth = -bbox_bottom;
}