/// @desc 

vSpd += grv;
image_angle -= 2 * hSpd;

var _collide = [pCollision,pLvl4Enemy];

if (array_length(move_and_collide(hSpd,vSpd,_collide)) > 0 or place_meeting(x+hSpd,y+vSpd,_collide)) {
	var _enemy = instance_place(x+hSpd,y+vSpd,pLvl4Enemy);
	if (_enemy != noone) {
		var _dir = point_direction(0,0,hSpd,vSpd);
		HurtEnemyLvl4(_enemy,5,lengthdir_x(20,_dir),lengthdir_y(20,_dir));	
	} else {
		_enemy = instance_place(x+hSpd,y+vSpd,oRockLvl4);
		if (_enemy != noone and _enemy.breakable) {
			repeat(50) {
				with(instance_create_depth(_enemy.x,_enemy.y,depth-1,oSquareParticle)) {
					direction = random(360);
					speed = random(4);
					spd = 0.05;
					radius = 5;
					image_blend = #060606;
				}
			}
			instance_destroy(_enemy);	
		}
	}
	
	var _list = ds_list_create();
	var _amount = collision_circle_list(x,y,24,[pLvl4Enemy,oRockLvl4],false,false,_list,false);
	for(var i = 0; i < _amount; i++) {
		if (_list[| i] == _enemy) continue;
		var _dir = point_direction(x,y,_list[| i].x,_list[| i].y);
		if (object_is_ancestor(_list[| i].object_index,pLvl4Enemy)) {
			HurtEnemyLvl4(_list[| i],2,lengthdir_x(5,_dir),lengthdir_y(5,_dir));
		} else if (_list[| i].breakable) {
			_list[| i].hsp = lengthdir_x(2,_dir);
			_list[| i].vsp = lengthdir_y(2,_dir);
		}
	}
	ds_list_destroy(_list);
	repeat(100) {
		with(instance_create_depth(x,y,depth-1,oTriangleParticle)) {
			image_blend = merge_color(c_ltgray,c_dkgray,random(1));
			direction = random(360);
			image_angle = random(360);
			speed = random(3);
			spd = random_range(0.03,0.06);
			radius = 6;
		}
	}
	ScreenShake(5,5);
	audio_play_sound(snExplosionShort,1,false,1,0,random_range(0.9,1));
	instance_destroy();
}