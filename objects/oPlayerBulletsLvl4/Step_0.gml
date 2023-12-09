/// @desc 

colNum = (colNum+1) % 3;
image_blend = cols[colNum];

var _collide = [pCollision, pLvl4Enemy];

var _spdX = lengthdir_x(spd,image_angle);
var _spdY = lengthdir_y(spd,image_angle);
if (array_length(move_and_collide(_spdX,_spdY,_collide)) > 0 or place_meeting(x,y,_collide)) {
	if (isOnScreen()) audio_play_sound(snLaserImpact,2,false,1,0,random_range(0.7,1.3));
	
	mask_index = -1;
	var _enemy = instance_place(x,y,oBossLvl4ShieldEye);
	if (_enemy != noone) {
		HurtEnemyLvl4(_enemy,1,lengthdir_x(5,image_angle),lengthdir_y(5,image_angle));	
	} else {
		_enemy = instance_place(x,y,pLvl4Enemy);
		if (_enemy != noone) {
			HurtEnemyLvl4(_enemy,1,lengthdir_x(5,image_angle),lengthdir_y(5,image_angle));
		} else if (isOnScreen()) {
			var _activator = instance_place(x,y,oDoorActivator);
			if (_activator != noone) _activator.activated = true;
		}
	}
	
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