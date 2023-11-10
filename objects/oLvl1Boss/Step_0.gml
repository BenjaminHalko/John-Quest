/// @desc 

enableLive;

// Bullets
if (global.audioTick and global.audioBeat % 2 == 0) {
	instance_create_layer(x,y,layer,oBulletBomb)
}

// Boss Flashing
flash = Approach(flash, 0, 0.3);
bigFlash = ApproachFade(bigFlash, 0, 0.05, 0.7);
image_blend = merge_color(c_white, c_red, flash);

x = ApproachFade(x,xstart-64,5,0.7);

y = ystart + sin((oMusicController.thisBeat % 4) * pi / 2) * 60;

x += random_range(-5, 5) * min(4, flash + bigFlash * 4);
y += random_range(-5, 5) * min(4, flash + bigFlash * 4);