/// @desc 

enableLive;

image_xscale = Approach(image_xscale, 1, 0.2);
image_yscale = image_xscale;

image_angle -= 10;

targetPercent = ApproachFade(targetPercent, 1, 0.1, 0.6);
x = lerp(xstart, targetX, targetPercent);
y = lerp(ystart, targetY, targetPercent);

flash = ApproachFade(flash, 0, 0.05, 0.7);

if (global.audioTick) {
	flash = 1;
	if(--beatCount <= 0) {
		var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
		for(var i = 0; i < 4; i++) {
			with(instance_create_depth(x,y,depth,oBullet)) {
				speed = 6;
				direction = i * 90 + _dir;
			}
		}
		repeat(50) {
			with(instance_create_depth(x+random_range(-16,16),y+random_range(-16,16),depth-1,oTriangleParticle)) {
				image_blend = c_white;
				direction = random(360);
				speed = random(5);
				spd = random_range(0.05, 0.2);
				radius = 10;
			}
		}
		ScreenShake(10, 5);
		instance_destroy();
	}
}