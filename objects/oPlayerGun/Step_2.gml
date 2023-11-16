/// @desc 

x = oPlayerLvl1.x;
y = oPlayerLvl1.y;

if (oPlayerLvl1.tempHurt == 0 and !oBossLvl1.inBetweenPhases and !oBossLvl1.showMovementTutorial) {
	if (--shotTimer <= 0) {
		instance_create_depth(x,y+random_range(-6,6),depth,oPlayerBullets);
		shotTimer = 5;
	}

	if (global.audioTick and global.audioBeat % 4 == 0) {
		instance_create_depth(x,y,depth,oPlayerBullets,{helix: true});
	}
}