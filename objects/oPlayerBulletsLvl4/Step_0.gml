/// @desc 

enableLive;

colNum = (colNum+1) % 3;
image_blend = cols[colNum];

var _collide = [global.collisionMap];

var _spdX = lengthdir_x(spd,image_angle);
var _spdY = lengthdir_y(spd,image_angle);
if (array_length(move_and_collide(_spdX,_spdY,_collide)) > 0 or place_meeting(x,y,_collide)) {
	repeat(20) {
		with(instance_create_depth(x+lengthdir_x(1,image_angle),y+lengthdir_y(1,image_angle),depth-1,oTriangleParticle)) {
			image_blend = choose(c_white,c_lime,c_yellow);
			image_angle = random(360);
			direction = other.image_angle + 180 + random_range(-60,60);
			speed = random(4);
			spd = 0.06;
			radius = 3;
		}
	}
	instance_destroy();
}