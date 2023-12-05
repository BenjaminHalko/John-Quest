/// @desc 

enableLive;

// Inherit the parent event
event_inherited();

if (--wait <= 0)
dirPercent = ApproachFade(dirPercent,1,0.05,0.7);
spd = Approach(spd, 1.5, 0.4);

var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
_dir = dir - angle_difference(dir, _dir) * dirPercent;

x += lengthdir_x(spd,_dir);
y += lengthdir_y(spd,_dir);

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