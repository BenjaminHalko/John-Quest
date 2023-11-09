/// @desc 

if(activate) {
	if (oPlayer.x == playerTarget) {
		instance_create_layer(x+480,oCamera.boundry.y + oCamera.boundry.sprite_height/2,layer,oLvl1Boss);
		oPlayer.autoMove = undefined;
		instance_create_depth(oPlayer.x,oPlayer.y,oPlayer.depth-1,oPlayerGun);
		instance_destroy();
	}
}