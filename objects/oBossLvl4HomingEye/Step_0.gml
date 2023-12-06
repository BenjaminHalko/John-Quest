/// @desc 

enableLive;

// Inherit the parent event
event_inherited();



if (--wait <= 0) {
	if (dirPercent != 1) {
		targetDir = point_direction(x,y,targetX,targetY);
	}
	dirPercent = Approach(dirPercent,1,0.1);
} else {
	targetX = oPlayer.x;
	targetY = oPlayer.y;
	spd = ApproachFade(spd, 4, 0.4,0.8);
	targetDir = point_direction(x,y,targetX,targetY);
}

var _dir = dir - angle_difference(dir, targetDir) * dirPercent;

x += lengthdir_x(spd+4*dirPercent,_dir);
y += lengthdir_y(spd+4*dirPercent,_dir);

if (hp <= 0) {
	repeat(40) {
		with(instance_create_depth(x+random_range(-8,8),y+random_range(-8,8),depth-1,oTriangleParticle)) {
			speed = random(4);
			spd = 0.06;
			image_angle = random(360);
			direction = random(360);
			radius = 7;
		}
	}
	instance_destroy();	
}