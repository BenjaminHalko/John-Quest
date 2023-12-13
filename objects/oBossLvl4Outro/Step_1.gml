/// @desc 

percent = ApproachFade(percent,1,0.005,0.7);
oPlayer.wavePercent = 1 - percent;

if (percent == 1)  {
	if (!createdTriangles and !audio_is_playing(mLvl4MusicBoss2)) {
		for(var i = -2; i < 34; i += 1.5) {
			for(var j = -2; j < 20; j += 1.5) {
				var _x = oCamera.x-240+480/32*i;
				var _y = oCamera.y-135+270/18*j;
				with(instance_create_depth(_x,_y,depth-1,oTriangleParticle)) {
					radius = 32;
					direction = point_direction(oBossLvl4Phase2.x+oBossLvl4Phase2.sprite_width/2,oBossLvl4Phase2.y,x,y);
					image_angle = direction+random_range(-30,30);
					speed = random(8);
					spd = random_range(0.005,0.04);
				}
			}
		}
		createdTriangles = true;
		instance_destroy(oBossLvl4Mouth);
		instance_destroy(oBossLvl4Eyes);
		instance_destroy(oFinalWeapon);
		instance_destroy(oBossLvl4Phase2);
		audio_play_sound(snExplosion,1,false);
		destroyCursors();
		wait = 15;
		playerMovePercent = 1;
	}
	
	if (createdTriangles) {
		if (!instance_exists(oTriangleParticle) and --wait <= 0)  {
			Transition(rCredits,1);
		}
	}
}