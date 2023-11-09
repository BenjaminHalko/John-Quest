/// @desc 

if(activate) {
	if (oPlayer.x == playerTarget) {
		instance_create_layer(playerTarget,y-32,layer,oLvl1Boss);
		instance_destroy();
	}
}