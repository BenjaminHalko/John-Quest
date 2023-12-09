/// @desc

if (place_meeting(x,y,oPlayer)) {
	instance_create_layer(0,0,"Boss",oBossLvl4UI);
	instance_create_layer(2464,768,"Rocks",oBigRock);
	instance_destroy();
}