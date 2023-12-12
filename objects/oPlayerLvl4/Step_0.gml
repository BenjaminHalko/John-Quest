/// @desc 

Input()
var _moveX = (keyRight - keyLeft) * allowMovement;
var _moveY = (keyDown - keyUp) * allowMovement;
var _fire = mouse_check_button(mb_left) * allowMovement;
var _changeItem = mouse_check_button_pressed(mb_right) * allowMovement;

// Movement
var _dir = point_direction(0,0,_moveX,_moveY);
hsp = ApproachFade(hsp,lengthdir_x(movespd*abs(_moveX),_dir),0.8,0.85);
vsp = ApproachFade(vsp,lengthdir_y(movespd*abs(_moveY),_dir),0.8,0.85);

// shooting
if (_changeItem) changeItem = true;
if (changeItem or itemPercent != 0) {
	itemPercent = Approach(itemPercent, changeItem*2, 0.1);
	if (itemPercent == 2) {
		item = 1 - item;
		changeItem = false;
	}
} else if (_fire) {
	if (--shotTimer <= 0) {
		var _shootDir = point_direction(x,y,mouse_x,mouse_y);
		if (item == 0) {
			with(instance_create_depth(x+random_range(-6,6)+lengthdir_x(20,_shootDir),y+random_range(-6,6)+lengthdir_y(20,_shootDir),depth-1,oPlayerBulletsLvl4)) {
				image_angle = _shootDir;
			}
			ScreenShake(2,2);
			shotTimer = 5;
			knockBack = 5;
			hsp -= lengthdir_x(0.2,_shootDir);
			vsp -= lengthdir_y(0.2,_shootDir);
		} else {
			with(instance_create_depth(x+lengthdir_x(20,_shootDir),y+lengthdir_y(20,_shootDir),depth-1,oBombLvl4)) {
				hSpd = lengthdir_x(8,_shootDir);
				vSpd = lengthdir_y(8,_shootDir);
			}
			
			ScreenShake(2,2);
			shotTimer = 20;
			knockBack = 10;
			hsp -= lengthdir_x(1,_shootDir);
			vsp -= lengthdir_y(1,_shootDir);
		}
	}
} else {
	shotTimer = 0;
}

// Collision
if (hsp != 0 or vsp != 0) {
	var _xStart = x;
	var _yStart = y;
	MoveAndCollide(hsp,vsp,0,-sign(vsp));
	var _testX1 = x;
	var _testY1 = y;
	repeat(3) MoveAndCollide(hsp,vsp,0,-sign(vsp));
	var _dist = point_distance(x,y,_xStart,_yStart);
	x = _xStart;
	y = _yStart;
	MoveAndCollide(hsp,vsp,-sign(hsp),0);
	var _testX2 = x;
	var _testY2 = y;
	repeat(3) MoveAndCollide(hsp,vsp,-sign(hsp),0);
	if (point_distance(x,y,_xStart,_yStart) < _dist+1) {
		x = _testX1;
		y = _testY1;
	} else {
		x = _testX2;
		y = _testY2;
	}
}

// hurt
if (hurt > 0) {
	hurt = Approach(hurt,0,1);
	yscale = random_range(0.5,1.8);
} else {
	yscale = 1;
}

var _enemy = instance_place(x,y,pLvl4Enemy);
if (_enemy != noone and hurt <= 0 and allowMovement) {
	var _enemyDir = point_direction(_enemy.x,_enemy.y,x,y);
	if (_enemy.object_index == oBossLvl4Laser) {
		_enemyDir = _enemy.image_angle - 90;
	}
	hsp = lengthdir_x(movespd*2,_enemyDir);
	vsp = lengthdir_y(movespd*2,_enemyDir);
	if (_enemy.allowKnockback) {
		with(_enemy) {
			knockback = 6;
			knockbackDir = _enemyDir+180;
		}
	}
	if (_enemy.object_index == oBossLvl4Laser) {
		_enemy.destroy = true;	
	}
	hurt = 60;
	//hp--;
	if (hp == 0) allowMovement = false;
	audio_play_sound(snPlayerDie,1,false);
}

// explode
if (hp <= 0) {
	if (--explosionWait <= 0) {
		if (++explosions == 16) {
			repeat(200) {
				with(instance_create_depth(x+random_range(-4,4),y+random_range(-4,4),depth-1,oTriangleParticle)) {
					radius = 10;
					speed = random(8);
					spd = 0.02;
					direction = random(360);
					image_angle = random(360);
				}
			}
			visible = false;
			audio_play_sound(snExplosion,1,false,1,0,0.7);
			explosionWait = 60;
		} else if (explosions >= 17) {
			Transition(rLvl4);
		} else {
			var _x = random_range(bbox_left-10,bbox_right+10);
			var _y = random_range(bbox_top-10,bbox_bottom+10);

			repeat(20) {
				with(instance_create_depth(_x+random_range(-4,4),_y+random_range(-4,4),depth-1,oTriangleParticle)) {
					radius = 8;
					speed = random(8);
					spd = 0.08;
					direction = random(360);
					image_angle = random(360);
				}
			}
			ScreenShake(10,5);
			audio_play_sound(snExplosionShort,1,false,0.8,0,0.8);
			explosionWait = 5;
		}
	}
}

// animation
propellerIndex = (propellerIndex + propellerSpd) % propellerNum;
knockBack = Approach(knockBack,0,1-(item == 1)*0.4);

// restore health
if (restoreHealth) {
	hp = Approach(hp,8,0.1);
	if (hp == 8) restoreHealth = false;
}
