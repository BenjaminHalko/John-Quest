/// @desc 

enableLive;

x = oPlayer.x;
y = oPlayer.y;

if (oPlayer.tempHurt == 0) {
	if (--shotTimer <= 0) {
		instance_create_depth(x,y+random_range(-6,6),depth,oPlayerBullets);
		ScreenShake(2,1);
		shotTimer = 5;
	}

	if (global.audioTick and global.audioBeat % 4 == 0) {
		instance_create_depth(x,y,depth,oPlayerBullets,{helix: true});
	}
}