/// @desc

if (global.defeatedBoss) {
	instance_create_layer(2464,768,"Rocks",oBigRock);
	instance_create_layer(0,0,"Boss",oBossLvl4Phase2);
	instance_destroy();
} else if (oPlayer.x > x) {
	ScreenShake(5,60);
	oPlayer.allowMovement = false;
	instance_create_layer(0,0,"Boss",oBossLvl4Phase1);
	instance_create_layer(0,0,"Boss",oBossLvl4UI);
	instance_create_layer(2464,768,"Rocks",oBigRock);
	instance_destroy();
}