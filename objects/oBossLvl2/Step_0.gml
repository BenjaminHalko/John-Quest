/// @desc 

if (global.playerHealth == 0) exit;

depth = -y;

// Intro
if (intro) {
	if (disappearPercent == 0) {
		if (--introWait == 0) {
			ActivateBossLvl2NPC();
		} else if (introWait < 0 and !instance_exists(oText) and !instance_exists(oTextQueued)) {
			intro = false;
		}
	}
}

// Dead
if shouldDie and x == oCamera.boundary.x + 240 and y == oCamera.boundary.y + 120 and eyeExpandPercent == 0 {
	dead = true;
	shouldDie = false;
	audio_sound_gain(oLvl2Controller.music,0,1000);
	audio_play_sound(snBossLvl1Roar,1,false);
}
if dead {
	if (deadPhase == 0) {
		shootPercent = Approach(shootPercent, 1.5, 0.015);
		ScreenShake(1,1);
		if (shootPercent == 1.5) {
			deadPhase++;
		}
	}
	
	if (deadPhase > 0 and deadPhase < 6) {
		shootPercent = ApproachFade(shootPercent,1.5,0.05,0.7);
		if (--deadWait <= 0) {
			deadPhase++;
			shootPercent += 2;
			var _x = eyes[0].obj.x + random_range(-64,64);
			var _y = eyes[0].obj.y + random_range(-64,64);
			repeat(100) {
				with(instance_create_depth(_x,_y,depth-100,oTriangleParticle)) {
					image_blend = c_white;
					direction = random(360);
					image_angle = random(360);
					speed = random_range(0.3,4);
					radius = 10;
					spd = 0.035;
				}
			}
			repeat(100) {
				with(instance_create_depth(x+random_range(-sprite_width/2,sprite_width/2),y+random_range(-3,3),depth+1,oSquareParticle)) {
					direction = random(180);
					speed = random_range(1,2);
					spd = 0.03;
					image_blend = merge_color(#BB00FF,#5500FF,random(360));
					depth = -y;
					radius = 2;
				}	
			}
			DropItems(x,y,array_create(5,oCoin));
			deadWait = 30;
			if (deadPhase == 6) {
				visible = false;
				deadWait = 70;
				repeat(200) {
					with(instance_create_depth(x+random_range(-sprite_width/2,sprite_width/2),y-random(sprite_height),depth+1,oSquareParticle)) {
						direction = random(360);
						speed = random(8);
						spd = 0.02;
						image_blend = merge_color(merge_color(#BB00FF,#5500FF,random(360)),c_white,0.5);
						depth = -y;
						radius = 3;
					}
				}
			}
			audio_play_sound(snExplosion,1,false,1,0,random_range(0.8,1.2));
			ScreenShake(20,10);
		}
	}
	
	if (deadPhase == 6) {
		if (deadWait <= 12) {
			shootPercent = ApproachFade(shootPercent,0,0.5,0.4);
			eyeSpinRotationDir = 1;
		}
		eyeSpinRotation = 0;
		if (--deadWait <= 0) {
			deadPhase++;
			repeat(500) {
				with(instance_create_depth(eyes[0].obj.x,eyes[0].obj.y,depth-100,oTriangleParticle)) {
					image_blend = c_white;
					direction = random(360);
					image_angle = random(360);
					speed = random_range(0.3,10);
					radius = 12;
				}
			}
			instance_create_depth(eyes[0].obj.x,eyes[0].obj.y,depth+1,oBossLvl2List);
			audio_play_sound(snExplosion,1,false);
			ScreenShake(15,90);
		}
	}
	
	if (deadPhase == 7) {
		shootPercent = Approach(shootPercent, 0, 0.5);
		eyeExpandPercent = Approach(eyeExpandPercent, 2, 0.03 + 0.02 * (eyeExpandPercent < 1));
		eyeSpinRotationDir = -1;
		if eyeExpandPercent == 2 {
			deadWait = 300;
			deadPhase++;
			audio_play_sound(snAscend,1,false);
		}
	}
	
	if (deadPhase >= 8) {
		repeat((irandom(max(1,(deadWait-100)/8)) <= 1)*min(4,zSpeed/2 + 2)) {
			var _x = random_range(oCamera.boundary.bbox_left, oCamera.boundary.bbox_right);
			var _y = random_range(oCamera.boundary.bbox_top, oCamera.boundary.bbox_bottom);
			with(instance_create_depth(_x,_y,-100000,oSquareParticle)) {
				image_blend = merge_color(c_red,c_orange,random(1));
				direction = 90;
				image_angle = random(360);
				speed = random_range(0.3,2);
				radius = 1;
				spd = 0.01;
			}
		}
		if (deadPhase == 8 and --deadWait <= 0) {
			deadPhase++;
			oPlayer.state = PlayerStateLocked;
		}
	}
	
	if (deadPhase == 9) {
		zSpeedAccel += 0.001;
		oPlayer.z += zSpeed;
		zSpeed += 0.015 + zSpeedAccel;
		oPlayer.image_angle += 2 + zSpeedAccel * 50;
		
		if (oPlayer.z > 400 and !instance_exists(oTransition)) {
			Save("lvl2","money",global.playerMoney);
			Transition(rLvl3);
		}
	}
	
	x = newX+random_range(-2,2);
	y = newY+random_range(-2,2);
}

#region Teleporting
if (isTeleporting) {
	if (eyeExpandPercent == 2-teleportAppear and (disappearPercent == 1.5 or eyeX != x or eyeY != y) and !intro) {
		var _dir = point_direction(eyeX,eyeY,newX,newY);
		var _dist = point_distance(eyeX,eyeY,newX,newY);
		var _spd = min(_dist, teleportMovementSpd);
		
		_spd *= clamp(1-(24-min(point_distance(eyeX,eyeY,xstart,ystart), _dist))/24,0.2,1);
		eyeX += lengthdir_x(_spd,_dir);
		eyeY += lengthdir_y(_spd,_dir);
		
		if (_dist < teleportMovementSpd) {
			isTeleporting = false;
			eyeX = newX;
			eyeY = newY;
		}
		
		if(!teleportAppear) {
			teleportAppear = true;
		}
		x = newX;
		y = newY;
	} else if (newX == eyeX and newY == eyeY) {
		var _boundary = oCamera.boundary;
		if (shouldDie) {
			newX = _boundary.x + 240;
			newY = _boundary.y + 120; 
		} else {
			var _found = false;
			repeat(100) {
				newX = irandom_range(_boundary.bbox_left, _boundary.bbox_right);
				newY = irandom_range(_boundary.bbox_top+sprite_height, _boundary.bbox_bottom);
			
				var _dir = abs(angle_difference(point_direction(eyeX,eyeY,newX,newY),point_direction(eyeX,eyeY,oPlayer.x,oPlayer.y)));
				if (_dir < 45 and !place_meeting(newX,newY,global.collisionMap) and point_distance(newX,newY,x,y) > 144) {
					_found = true;
					break;
				}
			}
		
			if (!_found) {
				do {
					newX = irandom_range(_boundary.bbox_left, _boundary.bbox_right);
					newY = irandom_range(_boundary.bbox_top+sprite_height, _boundary.bbox_bottom);
				} until (!place_meeting(newX,newY,global.collisionMap) and point_distance(newX,newY,x,y) > 144);
			}
		}
		
		if (teleportAppear) {
			eyeSpinRotationDir = -eyeSpinRotationDir;
			teleportAppear = false;
			teleportAppearWait = 30;
			xstart = x;
			ystart = y;
		}
	}
} else if (!isShooting and eyeExpandPercent == 0 and alarm[0] <= 0 and !dead and !intro and enemyHP != maxHp) {
	alarm[0] = (shootCounter == 0 ? 200 - 50 * (maxHp-enemyHP)/maxHp : 25 - 20 * (maxHp-enemyHP)/maxHp);	
}
#endregion

// Damage
entityCollision = (disappearPercent == 0 and !dead);
enemyAttackable = (eyeExpandPercent == 0);

#region Eyes
var _teleportFade = animcurve_channel_evaluate(eyeExpandCurve, max(0,eyeExpandPercent-(!teleportAppear)));
var _rotSpd = 2 * (3-max(0,_teleportFade)*2) * eyeSpinRotationDir;
if (dead) _rotSpd *= 1.5;
eyeSpinRotation -= _rotSpd;
for(var i = 0; i < 5; i++) {
	var _xNormal = eyes[i].x + eyeX;
	var _yNormal = eyes[i].y + eyeY - yEyeOffset;
	
	var _distance = 100;
	if (intro) _distance += 500 * disappearPercent;
	if (dead) {
		_distance *= eyeExpandPercent * 3;
	}
	var _xSpin = eyeX + lengthdir_x(_distance, eyeSpinRotation+360/5*i);
	var _ySpin = eyeY - yEyeOffset + lengthdir_y(_distance, eyeSpinRotation+360/5*i);
	
	if (i != 0) {
		_xNormal += Wave(-1,1,1+eyes[i].waveOffset,eyes[i].waveOffset) * (1-_teleportFade);
		_yNormal += Wave(-1,1,1+eyes[i].waveOffset*1.2,eyes[i].waveOffset*1.5) * (1-_teleportFade);
		eyes[i].obj.size = clamp(_teleportFade*3+deadPercent,0,1);
		eyes[i].obj.image_angle = Wave(-16,16,2,eyes[i].waveOffset) * (1-_teleportFade)*(1-deadPercent);
		eyes[i].obj.image_angle += Wave(-16,16,1,eyes[i].waveOffset) *_teleportFade*(1-deadPercent);
		eyes[i].obj.xscale = lerp(1,Wave(1.2,0.8,0.5,eyes[i].waveOffset),_teleportFade);
		eyes[i].obj.yscale = lerp(1,Wave(0.8,1.2,0.5,eyes[i].waveOffset),_teleportFade);
		eyes[i].obj.x = lerp(_xNormal, _xSpin, _teleportFade);
		eyes[i].obj.y = lerp(_yNormal, _ySpin, _teleportFade);
	} else {
		eyes[i].obj.xscale = lerp(Wave(0.7,1.06,1,0),1,_teleportFade+deadPercent);
		eyes[i].obj.yscale = lerp(Wave(0.9,1.2,1,0.3),1,_teleportFade+deadPercent);
		eyes[i].obj.xscale *= lerp(1,Wave(1.2,0.8,0.5,eyes[i].waveOffset),_teleportFade*(1-deadPercent));
		eyes[i].obj.yscale *= lerp(1,Wave(0.8,1.2,0.5,eyes[i].waveOffset),_teleportFade*(1-deadPercent));
		eyes[i].obj.image_angle = Wave(-16,16,1,eyes[i].waveOffset) * _teleportFade*(1-deadPercent);
		eyes[i].obj.x = lerp(_xNormal, _xSpin, max(0,_teleportFade));
		eyes[i].obj.y = lerp(_yNormal, _ySpin, max(0,_teleportFade));
	}
}
#endregion

#region Shooting
if (shootPercent > 0) {
	eyeSpinRotation -= eyeSpinRotationDir * shootPercent * 20;
	eyes[0].obj.xscale = lerp(eyes[0].obj.xscale,random_range(1.2,1.5), shootPercent);
	eyes[0].obj.yscale = lerp(eyes[0].obj.yscale,random_range(1.2,1.5), shootPercent);
	
	var _x = eyes[0].obj.x;
	var _y = eyes[0].obj.y;
	var _dist = 12 + deadPercent * 2;
	for(var i = 0; i < 4; i++) {
		eyes[i+1].obj.x = lerp(eyes[i+1].obj.x,_x+lengthdir_x(_dist, eyeSpinRotation+i*90),shootPercent);
		eyes[i+1].obj.y = lerp(eyes[i+1].obj.y,_y+lengthdir_y(_dist, eyeSpinRotation+i*90),shootPercent);
	}
	if (!dead and shootPercent == 1) {
		isShooting = false;
		var _num = 3;
		var _dir = point_direction(eyes[0].obj.x,eyes[0].obj.y,oPlayer.x,oPlayer.y);
		with(instance_create_depth(eyes[0].obj.x,eyes[0].obj.y,depth-1,oBossLvl2Fireball)) {
			speed = 4+(other.maxHp-other.enemyHP)/other.maxHp*2;
		}
	}
}
#endregion

// Dead
if (dead and deadPhase < 6) {
	for(var i = 0; i < 5; i++) {
		if (i != 0) {
			eyes[i].obj.xscale = 1 - deadPercent / 6;	
			eyes[i].obj.yscale = eyes[i].obj.xscale;
		}
		eyes[i].obj.image_angle = random_range(-20,20);
	}
}

// Values
if (!dead) eyeExpandPercent = Approach(min(2-teleportAppear,eyeExpandPercent), (intro or isTeleporting)*(2 - teleportAppear), 0.03);
disappearPercent = Approach(disappearPercent,(!teleportAppear and _teleportFade > 0) * 1.5,0.03-0.015*intro);
if (!dead) shootPercent = ApproachFade(shootPercent, isShooting, 0.1+(maxHp-enemyHP)/maxHp*0.5, 0.7);
if (dead) deadPercent = ApproachFade(deadPercent, 1, 0.02, 0.7);
flash = max(flash-0.1,0);

// Surface
if (!surface_exists(surf)) surf = surface_create(sprite_width,sprite_height);

// Particles
if (eyeExpandPercent != 0 and (!teleportAppear or eyeExpandPercent == 1) and disappearPercent < 1 and !dead) or intro {
	with(instance_create_depth(x+random_range(-sprite_width/2,sprite_width/2),y+random_range(-3,3),depth+1,oSquareParticle)) {
		direction = random(180);
		speed = 1;
		spd = 0.035;
		image_blend = merge_color(#BB00FF,#5500FF,random(360));
		depth = -y;
		radius = 2;
	}
}

// Get hit
if (flash != 0 and !isTeleporting and enemyAttackable) {
	audio_play_sound(snBreak,1,false);
	alarm[0] = 1;
	shootCounter = 0;
	DropItems(x,y,[oHeartDrop, oCoin, oCoin, oCoin, oCoin]);
	if (enemyHP <= 0) {
		shouldDie = true;
		with(pEnemy) {
			enemyHP = 0;
			state = ENEMYSTATE.DIE;
		}
	}
}