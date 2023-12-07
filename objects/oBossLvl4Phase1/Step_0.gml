/// @desc 

enableLive;
event_inherited();

if (keyboard_check_pressed(ord("H"))) attack = BOSSLVL4.HEXAGON;
if (keyboard_check_pressed(ord("C"))) attack = BOSSLVL4.CHARGE;
if (keyboard_check_pressed(ord("J"))) attack = BOSSLVL4.HOMING;
if (keyboard_check_pressed(ord("K"))) attack = BOSSLVL4.BULLETHELL;

var _boundary = oCamera.boundary;
if (_boundary != noone) {
	bLeft = _boundary.bbox_left+32;
	bRight = _boundary.bbox_right-32;
	bTop = _boundary.bbox_top+32;
	bBottom = _boundary.bbox_bottom-32;
}

var _switched = (lastAttack != attack);
lastAttack = attack;
switch(attack) {
	case BOSSLVL4.HEXAGON: {
		if (_switched) {
			timer = 90;
			hexagonPercent = 0;
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
				lasers: []
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
					lasers: []
				});
			}
			
			var _eyeList = [];
			for(var j = 0; j < array_length(hexagons); j++) {
				if (j < 2) {
					_eyeList = [[0,1],[0,5],[3,2],[3,4]];
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
			if (j != 0 and hexagons[j-1].dist <= 144) continue;

			if (hexagonPercent == 1) {
				hexagons[j].distSpd = Approach(hexagons[j].distSpd,(_playerDist + 64 < hexagons[j].dist),0.05,0.7);
				hexagons[j].dist += lerp(2,5,hexagons[j].distSpd) * animcurve_channel_evaluate(hexagonCurve,1-hexagons[j].spinSpdPercent);
				hexagons[j].spinSpdPercent = ApproachFade(hexagons[j].spinSpdPercent,0,0.01,0.8);
			}
			
			hexagons[j].rotation -= lerp(3,0.5,hexagonPercent)*hexagons[j].spinSpd*lerp(0.5,1,hexagons[j].spinSpdPercent);
			var _isOnScreen = false;
			for(var i = 0; i < 6; i++) {
				hexagons[j].eyes[i].x = x + lengthdir_x(hexagons[j].dist,360/6*i+hexagons[j].rotation);
				hexagons[j].eyes[i].y = y + lengthdir_y(hexagons[j].dist,360/6*i+hexagons[j].rotation);
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
		
		if (array_length(hexagons) <= 1 and --timer <= 0) {
			manageShield = true;
			eyeDist = ApproachFade(eyeDist,28,1,0.7);		
		}

		if (array_length(hexagons) == 0) {
			if (eyeDist == 28) attack = -1;
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
			chargeSpd = Approach(chargeSpd,20,1);
			var _hSpd = lengthdir_x(chargeSpd,chargeDir);
			var _vSpd = lengthdir_y(chargeSpd,chargeDir);
			if (chargeSpd == 20) {
				if (array_length(MoveAndCollide(_hSpd,_vSpd,0,0)) > 0) {
					stunned = true;
					ScreenShake(10,10);
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
			var _len = chargePercent * 20;
			x = xstart + lengthdir_x(_len,chargeDir+180);
			y = ystart + lengthdir_y(_len,chargeDir+180);
		}
	} break;
	case BOSSLVL4.HOMING: {
		if (_switched) {
			homingCount = 1;
			timer = 30;
		}
		
		if (homingPercent == 1) {
			if (homingCount > 5) {
				if (homingCount == 6) {
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
		
		if (manageShield) {
			eyeRotationSpd = 0;
			eyeDist = ApproachFade(eyeDist,16,0.5,0.7);
			if (eyeDist == 16) {
				manageShield = false;
				with(oBossLvl4ShieldEye) {
					spd = 8;
					dir = point_direction(other.x,other.y,x,y);
				}
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
					}
				}
				timer = 20 - flash * 10;
			}
		}
	} break;
	case BOSSLVL4.CHASE: {
		if (_switched) {
			timer = 60*5;
		}
	} break;
	default: {
		if (_switched) {
			timer = 30;	
		}
		
		if (--timer <= 0) {
			//attack = choose(BOSSLVL4.CHARGE, BOSSLVL4.HEXAGON, BOSSLVL4.HOMING);	
		}
	} break;
}


// Animation
var _hurtScale = random_range(0.5,1.8);
scale = lerp(lerp(Wave(0.85,1.15,0.5,0),1,stunPercent),_hurtScale,min(1,flash*2));
stunPercent = ApproachFade(stunPercent,stunned,0.1,0.7);
angle = Wave(-10,10,2,0) * stunPercent;

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

// Eyes Shield
if (manageShield) {
	var _eyeDist = lerp(eyeDist,Wave(64,72,2.5,0),stunPercent);
	eyeRotation -= (3 + 7 * chargePercent) * (1-stunPercent) * eyeRotationSpd;
	for(var i = 0; i < 6; i++) {
		eyes[i].x = x + lengthdir_x(_eyeDist,360/6*i+eyeRotation);
		eyes[i].y = y + lengthdir_y(_eyeDist,360/6*i+eyeRotation);
	}
}