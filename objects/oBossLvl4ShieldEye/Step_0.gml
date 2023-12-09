/// @desc 

enableLive;

// Inherit the parent event
event_inherited();

if (!surface_exists(surf)) surf = surface_create(size,size);

focusPercent = ApproachFade(focusPercent,1,0.05,0.7);

if (--focusTimer <= 0) {
	focusTimer = irandom_range(30,60);
	if (instance_exists(oBossLvl4Phase1) and oBossLvl4Phase1.stunned) focusTimer -= 15;
	focusPercent = 0;
	lastFocusX = focusX;
	lastFocusY = focusY;
	
	var _dir = random(360);
	var _len = 16;
	focusX = lengthdir_x(_len,_dir);
	focusY = lengthdir_y(_len,_dir);
	
	if (--focusIsOnPlayer < 0 and (irandom(5) == 0)) or (instance_exists(oBossLvl4Phase1) and oBossLvl4Phase1.stunned) {
		focusIsOnPlayer = irandom_range(1,3);
	}
}

if (focusIsOnPlayer <= 0) {
	var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
	focusX = lengthdir_x(16,_dir);
	focusY = lengthdir_y(16,_dir);
}

image_xscale = Wave(1.1,0.9,0.5,waveOffset)*scale;
image_yscale = Wave(0.9,1.1,0.5,waveOffset)*scale;

if (spd != 0) {
	var _hsp = lengthdir_x(spd,dir);
	var _vsp = lengthdir_y(spd,dir);
	if (array_length(MoveAndCollide(_hsp,_vsp,0,0)) > 0 or place_meeting(x,y,pCollision)) {
		explode = true;
	}
}

if (hp <= 0 or explode) {
	repeat(50) {
		with(instance_create_depth(x+random_range(-8,8),y+random_range(-8,8),depth-1,oTriangleParticle)) {
			radius = 7;
			speed = random(4);
			spd = 0.04;
			direction = random(360);
			image_angle = random(360);
		}
	
	}

	if (!oBossLvl4Phase1.dead) {
		ScreenShake(5,3);
		audio_play_sound(snExplosionShort,1,false,0.5);
	}
	instance_destroy();
}