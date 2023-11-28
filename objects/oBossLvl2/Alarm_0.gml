/// @desc 

enableLive;

if (shootCounter-- == 0) {
	isTeleporting = true;
	shootCounter = 3+round((maxHp-enemyHP)/maxHp*7);
	if (irandom(3) == 0) {
		repeat(4) {
			with(instance_create_layer(x,y,"Instances",oSlime)) {
				z = 200;
				grav = 0.1;
				do {
					var _dir = random(360);
					var _len = random(100);
					x = xstart+lengthdir_x(_len,_dir);
					y = ystart+lengthdir_y(_len,_dir);
				} until(!place_meeting(x,y,global.collisionMap));
			}
		}	
	}
} else {
	isShooting = true;
}