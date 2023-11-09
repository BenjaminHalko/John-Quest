/// @desc 

enableLive;

// Bullets

if (global.audioTick) {
	with(instance_create_layer(x,y,layer,oBullet)) {
		speed = -5;	
	}
}




// Boss Flashing
flash = Approach(flash, 0, 0.3);
bigFlash = ApproachFade(bigFlash, 0, 0.08, 0.7);
image_blend = merge_color(c_white, c_red, flash);

x = ApproachFade(x,xstart-64,5,0.7);