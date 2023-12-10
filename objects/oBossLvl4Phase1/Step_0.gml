/// @desc 

enableLive;
event_inherited();

if (keyboard_check_pressed(ord("P"))) dead = true;

if (intro) {
	if (--timer <= 0) {
		if (introPhase == -1) {
			timer = 70;
			introPhase++;
		} else if (introPhase == 0) {
			timer = 40;
			introPhase++;
		} else if (introPhase == 1) {
			oCamera.follow = id;
			timer = 60;
			introPhase++;
			eyeRotationSpd = 10;
		} else if (introPhase == 2) {
			if (eyeDist == 0) eyeDist = 400;
			eyeDist = ApproachFade(eyeDist,100,3,0.7);
			eyeRotationSpd = ApproachFade(eyeRotationSpd,2,0.05,0.8);
			if (eyeDist == 100) {
				timer = 30;
				introPhase++;
			}
		} else if (introPhase == 3) {
			if (introPercent == 0) {
				ScreenShake(2,80);
				audio_play_sound(snBossLvl1Roar,1,false,1,1);
				audio_play_sound(snBossLvl4Roar,1,false);
			}
			
			introPercent = ApproachFade(introPercent,1,0.05,0.8);
			image_blend = merge_color(c_black,c_white,introPercent);
			if (introPercent == 1) {
				introPhase++;
				timer = 40;
			}
		} else if (introPhase == 4) {
			eyeRotationSpd = ApproachFade(eyeRotationSpd,1,0.05,0.8);
			eyeDist = ApproachFade(eyeDist,28,5,0.7);
			if (eyeDist == 28) {
				introPhase++;
				timer = 60;
			}
		} else if (introPhase == 5) {
			oCamera.follow = oPlayer;
			oPlayer.allowMovement = true;
			intro = false;
		}
	}
	
	if (introPhase > 0) {
		var _len = point_distance(oPlayer.x,oPlayer.y,x-160,y-32);
		var _dir = point_direction(oPlayer.x,oPlayer.y,x-160,y-32);
		if (_len < oPlayer.movespd) {
			oPlayer.hsp = ApproachFade(oPlayerLvl4.hsp,0,0.05,0.7);
			oPlayer.vsp = ApproachFade(oPlayerLvl4.vsp,0,0.05,0.7);
		} else {
			oPlayer.hsp = ApproachFade(oPlayer.hsp,lengthdir_x(oPlayer.movespd,_dir),0.5,0.7);
			oPlayer.vsp = ApproachFade(oPlayer.vsp,lengthdir_y(oPlayer.movespd,_dir),0.5,0.7);
		}
	}
	
	if (introPhase > 3 and eyeDist != 28) {
		x = bCenterX+random_range(-1,1);
		y = bCenterY+random_range(-1,1);	
	}
	
	scale = Wave(0.85,1.15,3-introPercent*2.5,0);
	
	// Shield
	eyeRotation -= lerp(0.1,3,introPercent)*eyeRotationSpd;
	for(var i = 0; i < 6; i++) {
		eyes[i].x = x + lengthdir_x(eyeDist,360/6*i+eyeRotation);
		eyes[i].y = y + lengthdir_y(eyeDist,360/6*i+eyeRotation);
	}
} else if (dead) {
	with(oBossLvl4ShieldEye) {
		explode = true;
	}
	if (explosionCount < maxExplosions) {
		if (oCamera.follow != id) {
			manageShield = false;
			oCamera.follow = id;
			oPlayer.allowMovement = false;
			timer = 0;
			x = bCenterX;
			y = bCenterY;
			vSpd = -16;
			audio_play_sound(snBossLvl1Roar,1,false);
			audio_play_sound(snBossLvl4Roar,1,false);
		}
		
		x = bCenterX + random_range(-8,8);
		y = bCenterY + random_range(-8,8);
		scale = random_range(0.5,1.8);
		if (--timer <= 0) {
			var _x = random_range(bbox_left-10,bbox_right+10);
			var _y = random_range(bbox_top-10,bbox_bottom+10);
			
			
			repeat(100) {
				with(instance_create_depth(_x+random_range(-4,4),_y+random_range(-4,4),depth-1,oTriangleParticle)) {
					radius = 10;
					speed = random(8);
					spd = 0.03;
					direction = random(360);
					image_angle = random(360);
				}
			}
			
			ScreenShake(10,5);
			
			audio_play_sound(snExplosion,1,false,0.5,0,0.8);
			
			explosionCount++;
			timer = 30;
		}
		
		if (explosionCount == maxExplosions) {
			timer = 60;
			scale = 1;
		}
	} else if (y >= bCenterY + 170) {
		if (explosionCount == maxExplosions) {
			mushroomY = bCenterY-150;
			y = bCenterY + 170;
			
			repeat(100) {
				with(instance_create_depth(x+random_range(-4,4),y+random_range(-4,4),depth+1,oSquareParticle)) {
					radius = 3;
					speed = random(4);
					spd = 0.018;
					direction = random(180-80)+40;
					image_angle = random(360);
					image_blend = #122029;
				}
			}
				
			ScreenShake(2,30);
			audio_play_sound(snExplosion,1,false,1,0,0.6);
			explosionCount = maxExplosions+1;
			vSpd = 1;
			timer = 120;
		}
		
		if (mushroomY >= y) {
			if (--timer <= 0) {
				oCamera.follow = oPlayer;
				oPlayer.allowMovement = true;
				oPlayer.restoreHealth = true;
				Save("lvl4","defeatedBoss",true);
				Save("lvl4","x",bCenterX);
				Save("lvl4","y",bCenterY);
				instance_destroy(oBossLvl4Laser);
				instance_destroy(oBossLvl4ShieldEye);
				instance_destroy();
			}
		} else if (--timer <= 0) {
			mushroomY += vSpd;
			vSpd += 0.1;
			if (mushroomY >= y) {
				audio_play_sound(snMushroom,1,false,1,0,0.6);
				timer = 90;
			}
	
		}
	} else {
		oCamera.follow = noone;
		
		if (--timer <= 0) {
			if (timer == 0) {
				repeat(200) {
					with(instance_create_depth(x+random_range(-4,4),y+random_range(-4,4),depth+1,oTriangleParticle)) {
						radius = 10;
						speed = random(8);
						spd = 0.02;
						direction = random(360);
						image_angle = random(360);
					}
				}
				audio_play_sound(snExplosion,1,false);
				ScreenShake(10,60);
			}
			angle -= 20;
			y += vSpd;
			vSpd = min(vSpd+0.1,4);
			if (vSpd < 0 and vSpd > -12.5) {
				vSpd = 4;
				scale = 0.5;
				image_blend = c_dkgray;
				depth = layer_get_depth("Vignette")+1;
			}
		}
	}
} else {
	if (hp <= 0) dead = true;
	var _switched = (lastAttack != attack);
	lastAttack = attack;
	switch(attack) {
		case BOSSLVL4.HEXAGON: {
			if (_switched) {
				var _dir = random(360);
				var _len = random(144);
				targetX = round(bCenterX+lengthdir_x(_len,_dir));
				targetY = round(bCenterY+lengthdir_y(_len,_dir));
			
				timer = 90;
				hexagonPercent = 0;
				hexagonLastStart = -1;
				var _spin = [1,-1,2,-2];
			
				// Create Hexagons
				eyeDist = 0;
				manageShield = false;
				hexagons = [{
					eyes: eyes,
					dist: 28,
					rotation: eyeRotation,
					spinSpd: _spin[0],
					distSpd: 0,
					spinSpdPercent: 1,
					lasers: [],
					x: x,
					y: y,
					num: 0
				}];
				for(var i = 1; i < array_length(_spin); i++) {
					var _eyes = [];
					repeat(6) {
						array_push(_eyes,instance_create_depth(0,0,depth+1,oBossLvl4ShieldEye));	
					}
					array_push(hexagons, {
						eyes: _eyes,
						dist: 0,
						rotation: random(360),
						spinSpd: _spin[i],
						distSpd: 0,
						spinSpdPercent: 1,
						lasers: [],
						x: x,
						y: y,
						num: i
					});
				}
			
				var _eyeList = [];
				for(var j = 0; j < array_length(hexagons); j++) {
					if (j < 2) {
						_eyeList = [[0,1],[5,0],[2,3],[3,4]];
					} else {
						_eyeList = [[0,1],[2,3],[4,5]];	
					}
					for(var i = 0; i < array_length(_eyeList); i++) {
						array_push(hexagons[j].lasers,instance_create_depth(hexagons[j].eyes[_eyeList[i][0]].x,hexagons[j].eyes[_eyeList[i][0]].y,depth+2,oBossLvl4Laser,{eye1: hexagons[j].eyes[_eyeList[i][0]], eye2: hexagons[j].eyes[_eyeList[i][1]]}));
					}
				}
			}
			hexagonPercent = ApproachFade(hexagonPercent,1,0.02,0.7);
		
			var _playerDist = point_distance(x,y,oPlayer.x,oPlayer.y);
			var _lastDist = 0;
			for(var j = 0; j < array_length(hexagons); j++) {
				if (hexagons[j].dist < 96) {
					hexagons[j].x = x;	
					hexagons[j].y = y;	
				} else if (hexagons[j].num > hexagonLastStart) {
					var _dir = random(360);
					var _len = random(144);
					targetX = round(bCenterX+lengthdir_x(_len,_dir));
					targetY = round(bCenterY+lengthdir_y(_len,_dir));
					hexagonLastStart = hexagons[j].num;
				}
			
				if (j != 0 and hexagons[j-1].dist <= 144) continue;

				if (hexagonPercent == 1) {
					hexagons[j].distSpd = Approach(hexagons[j].distSpd,(_playerDist + 64 < hexagons[j].dist),0.05,0.7);
					hexagons[j].dist += lerp(2,5,hexagons[j].distSpd) * animcurve_channel_evaluate(hexagonCurve,1-hexagons[j].spinSpdPercent);
					hexagons[j].spinSpdPercent = ApproachFade(hexagons[j].spinSpdPercent,0,0.01,0.8);
				}
			
			
				hexagons[j].rotation -= lerp(3,0.5,hexagonPercent)*hexagons[j].spinSpd*lerp(0.5,1,hexagons[j].spinSpdPercent);
				var _isOnScreen = false;
				for(var i = 0; i < 6; i++) {
					hexagons[j].eyes[i].x = hexagons[j].x + lengthdir_x(hexagons[j].dist,360/6*i+hexagons[j].rotation);
					hexagons[j].eyes[i].y = hexagons[j].y + lengthdir_y(hexagons[j].dist,360/6*i+hexagons[j].rotation);
					with(hexagons[j].eyes[i]) {
						_isOnScreen = _isOnScreen or isOnScreen();
					}
				}
				if (!_isOnScreen) {
					for(var i = 0; i < array_length(hexagons[j].lasers); i++) {
						with(hexagons[j].lasers[i]) {
							_isOnScreen = _isOnScreen or isOnScreen();
						}
					}
				}
			
				if (hexagons[j].dist > 560 and !_isOnScreen) {
					if (eyes[0] != hexagons[j].eyes[0]) {
						for(var i = 0; i < 6; i++) {
							instance_destroy(hexagons[j].eyes[i]);
						}
					}
					for(var i = 0; i < array_length(hexagons[j].lasers); i++) {
						instance_destroy(hexagons[j].lasers[i]);
					}
				
					array_delete(hexagons,j,1);
					j--;
				}
			}
	
			moveToPoint(targetX,targetY);
		
			if (array_length(hexagons) <= 1 and --timer <= 0) {
				manageShield = true;
				eyeDist = ApproachFade(eyeDist,28,1,0.5);	
			}

			if (array_length(hexagons) == 0) {
				if (eyeDist > 27.99) {
					attack = -1;
					eyeDist = 28;
				}
			}
		} break;
		case BOSSLVL4.CHARGE: {
			if (_switched) {
				xstart = x;
				ystart = y;
				chargeSpd = 5;
				timer = 180;
			}
		
			if (stunned) {
				spd = ApproachFade(spd,0,0.5,0.7);
				dir = point_direction(x,y,(bLeft+bRight)/2,(bTop+bBottom)/2);
			
				x += lengthdir_x(spd,dir);
				y += lengthdir_y(spd,dir);
			
				if (--timer <= 0) {
					chargePercent = 0;
					stunned = false;
					attack = -1;
				}
			} else if (chargePercent == 1) {
				spd = 8;
				chargeSpd = Approach(chargeSpd,20-(chargeSpd != 20 and place_meeting(x,y,pCollision)),1);
				var _hSpd = lengthdir_x(chargeSpd,chargeDir);
				var _vSpd = lengthdir_y(chargeSpd,chargeDir);
				if (chargeSpd == 20) {
					if (array_length(MoveAndCollide(_hSpd,_vSpd,0,0)) > 0) {
						stunned = true;
						ScreenShake(10,10);
						audio_play_sound(snExplosion,1,false,0.7,0,0.8);
					}
				} else {
					x += _hSpd;
					y += _vSpd;
				}
			
				CreateAfterImage(id);
				with(oBossLvl4ShieldEye) {
					CreateAfterImage(id);	
				}
			} else {
				chargePercent = ApproachFade(chargePercent,1,0.02,0.7);
				chargeDir = point_direction(x,y,oPlayer.x,oPlayer.y);
				var _len = chargePercent * 32;
				x = xstart + lengthdir_x(_len,chargeDir+180);
				y = ystart + lengthdir_y(_len,chargeDir+180);
			}
		} break;
		case BOSSLVL4.HOMING: {
			if (_switched) {
				homingCount = 1;
				timer = 60;
				var _dir = random(360);
				var _len = random(128);
				targetX = round(bCenterX+lengthdir_x(_len,_dir));
				targetY = round(bCenterY+lengthdir_y(_len,_dir));
				spd = 0;
			}
		
			if (x != targetX or y != targetY) {
				moveToPoint(targetX,targetY);
			} else if (homingPercent == 1) {
				if (homingCount > 3) {
					if (homingCount == 4) {
						homingCount++;
						timer = 180;
					} else if (--timer <= 0) {
						if (!manageShield) {
							eyes = [];
							repeat(6) {
								array_push(eyes,instance_create_depth(x,y,depth+1,oBossLvl4ShieldEye));
							}
							eyeDist = 0;
							eyeRotationSpd = 1;
						}
						manageShield = true;
						eyeDist = ApproachFade(eyeDist,28,1,0.7);
						if (eyeDist == 28) {
							attack = -1;
							homingPercent = 0;
						}
					}
				} else if (--timer <= 0) {
					var _dirEye = random(360);
					for(var i = 0; i < 6; i++) {
						with(instance_create_depth(x,y,depth+1,oBossLvl4HomingEye)) {
							moveDir = 360/6*i + _dirEye	
						}
					}
					homingCount++;
					timer = 30;
				}
			} else {
				homingPercent = ApproachFade(homingPercent,1,0.02,0.7);
				eyeRotationSpd = 1-homingPercent;
				if (homingPercent == 1) {
					manageShield = false;
					with(oBossLvl4ShieldEye) {
						instance_change(oBossLvl4HomingEye,false);
						HomingEyeInit();
						moveDir = point_direction(other.x,other.y,x,y);
					}
				}
			}
		} break;
		case BOSSLVL4.BULLETHELL: {
			if (_switched) {
				timer = 15;
			}
		
			if (x != bCenterX or y != bCenterY) {
				moveToPoint(bCenterX,bCenterY);
			} else if (manageShield) {
				eyeRotationSpd = 0;
				eyeDist = ApproachFade(eyeDist,16,0.5,0.7);
				if (eyeDist == 16) {
					manageShield = false;
					with(oBossLvl4ShieldEye) {
						spd = 8;
						dir = point_direction(other.x,other.y,x,y);
					}
					if (keyboard_check(vk_space)) dead = true;
				}
			} else {
				if (--timer < 0) {
					var _dir = random(60);
					var _scale = random_range(0.5,0.8);
					for(var i = 0; i < 6; i++) {
						with(instance_create_depth(x,y,depth+1,oBossLvl4ShieldEye)) {
							scale = _scale;
							spd = 6-_scale*3;
							dir = 360/6*i+_dir;
							hp = 3;
						}
					}
					timer = 20;
				}
			}
		} break;
		case BOSSLVL4.CHASE: {
			if (_switched) {
				timer = 60*6;
				spd = 0;
				dir = point_direction(x,y,oPlayer.x,oPlayer.y);
			}
		
			var _spd = 2.5;
			spd = ApproachFade(spd,(--timer > 0)*_spd,0.1,0.7);
			eyeRotationSpd = 1 + (spd/_spd) * 2;
			eyeDist = lerp(28,48,spd/_spd);
			dir = ApproachCircleEase(dir,point_direction(x,y,oPlayer.x,oPlayer.y),2,0.7);
			x += lengthdir_x(spd,dir);
			y += lengthdir_y(spd,dir);
		
			if (spd == 0) attack = -1;
		} break;
		case BOSSLVL4.SPINCYCLE: {
			if (_switched) {
				hexagonPercent = 0;
				for(var i = 0; i < 6; i++) {
					instance_create_depth(eyes[i].x,eyes[i].y,depth+2,oBossLvl4Laser,{eye1: id, eye2: eyes[i]});
				}
				timer = 60*6;
				spinCycleSwitchPercent = 0;
				spinCyclePercent = 0;
				manageShield = false;
			}
		
			if (x != bCenterX or y != bCenterY) {
				moveToPoint(bCenterX,bCenterY);
			} else if (timer <= 0) {
				angle = ApproachFade(angle,0,10,0.5);
				spinCyclePercent = ApproachFade(spinCyclePercent, 0, 0.05, 0.7);
				eyeRotationSpd = ApproachFade(eyeRotationSpd,1,0.05,0.5);
				if (spinCyclePercent <= 0.2) {
					hexagonPercent = ApproachFade(hexagonPercent,0,0.05,0.5);
					if (spinCyclePercent == 0 and hexagonPercent == 0) {
						manageShield = true;
						instance_destroy(oBossLvl4Laser);
						attack = -1;
					}
				}
			} else if (hexagonPercent != 1) {
				hexagonPercent = ApproachFade(hexagonPercent,1,0.02,0.7);
				spinCyclePercent = ApproachFade(spinCyclePercent, 0.05, 0.001, 0.7);
			} else {
				spinCyclePercent = ApproachFade(spinCyclePercent, 1, 0.02, 0.7);
				var _targetSpd = 0.3;
				if (--timer <= 60 * 3) {
					if (spinCycleSwitchPercent >= 1/3) {
						spinCycleSwitchPercent = ApproachFade(spinCycleSwitchPercent,1,0.01,0.7);
					} else {
						spinCycleSwitchPercent = ApproachFade(spinCycleSwitchPercent,1/3,0.01,0.6);
						_targetSpd = 0.5;
					}
				}
				eyeRotationSpd = ApproachFade(eyeRotationSpd,_targetSpd,0.05,0.7);	
				angle = Wrap(angle - 3 * eyeRotationSpd,0,360);
			}
		
			eyeRotation -= 3 * eyeRotationSpd;
			for(var i = 0; i < 6; i++) {
				var _amount = max(0,spinCycleSwitchPercent-1/3)*3;
				if (i % 2) _amount = 1 - min(1,spinCycleSwitchPercent*3);
				var _eyeDist = lerp(eyeDist,lerp(Wave(48,56,0.5,0),500,_amount),spinCyclePercent);
				eyes[i].x = x + lengthdir_x(_eyeDist,360/6*i+eyeRotation);
				eyes[i].y = y + lengthdir_y(_eyeDist,360/6*i+eyeRotation);
			}
		} break;
		case BOSSLVL4.DVD: {
			if (_switched) {
				dir = random(360);
				timer = 60*10;
				dvdShootTimer = 30;
				dvdShootDir = random(360);
				spd = 0;
			}
		
			var _spd = 2;
			spd = ApproachFade(spd,(--timer > 0)*_spd,0.05,0.7);
			eyeRotationSpd = 1 + (spd/_spd) * 3;
			eyeDist = lerp(28,64,spd/_spd);
		
			var _hsp = lengthdir_x(spd,dir);
			var _vsp = lengthdir_y(spd,dir);
		
			if (array_length(MoveAndCollide(_hsp,_vsp,0,0)) > 0) {
				dir = point_direction(x,y,bCenterX,bCenterY) + random_range(-40,40);	
			}
		
			if (--dvdShootTimer < 0 and timer > 0) {
				var _scale = random_range(0.4,0.8);
				for(var i = 0; i < 2; i++) {
					with(instance_create_depth(x,y,depth+1,oBossLvl4ShieldEye)) {
						scale = _scale;
						spd = 5-_scale*3;
						dir = other.dvdShootDir + i * 180;
						hp = 2;
					}
				}
				dvdShootTimer = 15;
				dvdShootDir -= 30;
			}
		
			if (spd == 0) attack = -1;
		} break;
		default: {
			if (_switched) {
				timer = 30;	
			}
		
			eyeRotationSpd = ApproachFade(eyeRotationSpd,1,0.1,0.7);
		
			if (--timer <= 0) {
				if (hp <= maxHp * 0.15) {
					attack = BOSSLVL4.BULLETHELL;
				} else {
					do {
						attack = choose(BOSSLVL4.CHARGE, BOSSLVL4.HEXAGON, BOSSLVL4.HOMING, BOSSLVL4.CHASE, BOSSLVL4.DVD, BOSSLVL4.SPINCYCLE);	
					} until (attack != actualLastAttack);
					actualLastAttack = attack;
				}
			}
		} break;
	}
	
	// Animation
	var _hurtScale = random_range(0.5,1.8);
	scale = lerp(lerp(Wave(0.85,1.15,0.5,0),1,stunPercent),_hurtScale,min(1,flash*2));
	stunPercent = ApproachFade(stunPercent,stunned,0.1,0.7);
	if (attack != BOSSLVL4.SPINCYCLE) angle = Wave(-10,10,2,0) * stunPercent;

	// Stun Particles
	if (stunned) {
		stunParticleRotation -= 10;
		for(var i = 0; i < 3; i++) {
			var _dir = 360/3*i + stunParticleRotation;
			with(instance_create_depth(x+lengthdir_x(18,_dir),bbox_top-8+lengthdir_y(8,_dir)+lengthdir_x(18,_dir)*Wave(-0.2,0.2,1.5,0),depth-1,oSquareParticle)) {
				image_blend = c_white;
				spd = 0.3;
				radius = 1;
			}
		}
	}

	// HP
	if (attack != BOSSLVL4.BULLETHELL) {
		hp = max(hp,maxHp*0.15);	
	}

	// Eyes Shield
	if (manageShield) {
		var _eyeDist = lerp(eyeDist,Wave(64,72,2.5,0),stunPercent);
		eyeRotation -= (3 + 10 * chargePercent) * (1-stunPercent) * eyeRotationSpd;
		for(var i = 0; i < 6; i++) {
			eyes[i].x = x + lengthdir_x(_eyeDist,360/6*i+eyeRotation);
			eyes[i].y = y + lengthdir_y(_eyeDist,360/6*i+eyeRotation);
		}
	}
}