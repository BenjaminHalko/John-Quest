/// @desc 

if(activate) {
	if (oPlayerLvl1.x == playerTarget) {
		instance_create_layer(x+480+64,oCamera.boundary.y + oCamera.boundary.sprite_height/2,layer,oBossLvl1);
		oPlayerLvl1.autoMove = undefined;
		instance_create_depth(oPlayerLvl1.x,oPlayerLvl1.y,oPlayerLvl1.depth-1,oPlayerGun);
		instance_create_depth(0,0,layer_get_depth("Bloom")+1,oBossLvl1UI);
		instance_destroy();
	}
}