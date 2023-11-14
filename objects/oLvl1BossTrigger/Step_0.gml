/// @desc 

if(activate) {
	if (oPlayer.x == playerTarget) {
		instance_create_layer(x+480+64,oCamera.boundary.y + oCamera.boundary.sprite_height/2,layer,oLvl1Boss);
		oPlayer.autoMove = undefined;
		instance_create_depth(oPlayer.x,oPlayer.y,oPlayer.depth-1,oPlayerGun);
		instance_create_depth(0,0,layer_get_depth("Bloom")+1,oLvl1BossUI);
		instance_destroy();
	}
}