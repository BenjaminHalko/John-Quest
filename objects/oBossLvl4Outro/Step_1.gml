/// @desc 

enableLive;

percent = ApproachFade(percent,1,0.005,0.7);
oPlayer.wavePercent = 1 - percent;

if (percent == 1)  {
	if (--wait <= 0 and !createdTriangles) {
		for(var i = -2; i < 64; i += 2) {
			for(var j = -2; j < 20; j += 2) {
				var _x = oCamera.x-240+480/32*i;
				var _y = oCamera.y-135+270/18*j;
				with(instance_create_depth(_x,_y,depth-1,oTriangleParticle)) {
					radius = 32;
					direction = 180;
					image_angle = random(360);
					speed = random_range(4,6);
					spd = random_range(0.005,0.04);
				}
			}
		}
		createdTriangles = true;
		instance_destroy(oBossLvl4Mouth);
		instance_destroy(oBossLvl4Eyes);
		instance_destroy(oBossLvl4Phase2);
		destroyCursors();
	}
	
	if (createdTriangles) {
		playerMovePercent = ApproachFade(playerMovePercent,1,0.05,0.7);
	}
}