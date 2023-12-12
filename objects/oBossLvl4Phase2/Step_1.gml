/// @desc 

enableLive;

if (keyboard_check_pressed(ord("P"))) dead = true;

// Intro
if (intro) {
	if (stepCounter == 5) {
		step = false;
		stepCounter++;
		openMouth = true;
	}
}

// Stepping
if (fall) {
	stepPercent = Approach(stepPercent,0,0.1);
	if (stepPercent == 0) {
		ScreenShake(5,15);
		fall = false;
		stepWait = 30;
		if (x < oCamera.x-300 and !intro) stepWait = 10;
		yStepBegin = y-50;
		stepCounter++;
	}
	x += 3.5;
	if (!intro and x < oCamera.x-300) x += 2.5;
} else if (--stepWait <= 0 and step) {
	stepPercent = Approach(stepPercent,1,0.02);
	if (stepPercent == 1) {
		yStepTarget = oCamera.y+20;
		if (x > 12900) {
			yStepTarget = 1660;
		}
		fall = true;
	}
	x += 3;
	if (!intro and x < oCamera.x-300) x += 2.5;
}
y = lerp(yStepTarget,yStepBegin,stepPercent);
x = min(x,stopX);
if (x == stopX and stepPercent == 0) {
	step = false;
}

// Mouth Fireball 
mouthYPercent = ApproachFade(mouthYPercent,openMouth,0.1,0.7);
mouthY = mouthYPercent * 64;

if (openMouth) {
	if (!dead) {
		repeat(2) {
			var _len = 48;
			var _dir = 180 + random_range(-120,120);
			with(instance_create_depth(x+128+random_range(-2,2)+lengthdir_x(_len,_dir),y+72+random_range(-2,2)+lengthdir_y(_len,_dir),depth-2,oSquareParticle)) {
				image_blend = merge_color(#EE371B,#EEA01B,random(1));
				direction = _dir+180+random_range(-5,5);
				speed = random(4);
				speed += other.x - other.xprevious;
				spd = 0.02;
			}
		}
		var _fireballLeft = (!instance_exists(fireball) or fireball.go);
		mouthBurnPercent = ApproachFade(mouthBurnPercent,0.5+createdFireball*(!_fireballLeft),0.05,0.7);
		if (mouthYPercent >= 0.8) {
			if (!createdFireball) {
				createdFireball = true;
				mouthWait = 60;
				fireball = instance_create_depth(x+124,y+74,depth-1,oBossLvl4Fireball);
			} else if (--mouthWait <= 0 and x != stopX) {
				if (_fireballLeft) {
					openMouth = false;
				} else {
					ScreenShake(5,10);
					fireball.go = true;
					fireball.depth = depth - 5;
					mouthWait = 30;
				}
			}
		
			if (instance_exists(fireball) and !fireball.go) {
				fireball.x = x+124;
				fireball.y = y+74;
			}
		}
	}
} else {
	createdFireball = false;
	mouthBurnPercent = 0.5;
	if (!step and intro) {
		intro = false;
		stepWait = 30;
		step = true;
		fall = false;
	}
	
	if (!intro and --mouthOpenWait <= 0 and (x < noAttackX or (x == stopX and !step))) {
		openMouth = true;
		mouthOpenWait = random(60*2.5);
	}
}

// Shoot eyes
shootEyesPercent = ApproachFade(shootEyesPercent,shootEyes,0.2,0.6);
if (eye1 == noone) {
	if (shootEyes) {
		eye1 = instance_create_depth(x+96,y-30,depth-3,oBossLvl4ShieldEye);
		eye1.scale = 0;
		eye1.red = true;
		eye1.image_xscale = 0;
		eye1.image_yscale = 0;
		eye1.hp = 5;
	}
} else if (instance_exists(eye1)) {
	eye1.x = x+96;
	eye1.y = y-30;
	eye1.scale = Approach(eye1.scale,0.8,0.06);
	if (eye1.scale == 0.8) {
		eye1.depth = depth-5;
		eye1.spd = 8;
		eye1.dir = point_direction(eye1.x,eye1.y,oPlayer.x,oPlayer.y)+random_range(-30,30);
		eye1 = noone;
	}
}
	
if (eye2 == noone) {
	if (shootEyes and instance_exists(eye1) and eye1.scale > 0.4) {
		eye2 = instance_create_depth(x+162,y-26,depth-3,oBossLvl4ShieldEye);
		eye2.scale = 0;
		eye2.red = true;
		eye2.image_xscale = 0;
		eye2.image_yscale = 0;
		eye2.hp = 5;
	}
} else if (instance_exists(eye2)) {
	eye2.scale = Approach(eye2.scale,0.8,0.06);
	eye2.x = x+162;
	eye2.y = y-26;
	if (eye2.scale == 0.8) {
		eye2.depth = depth-5;
		eye2.spd = 8;
		eye2.dir = point_direction(eye2.x,eye2.y,oPlayer.x,oPlayer.y)+random_range(-30,30);
		eye2 = noone;
	}
}

if (--shootEyesWait <= 0 and !intro and (x < noAttackX or shootEyes)) {
	shootEyes = !shootEyes;
	if (shootEyes) shootEyesWait = 60*3;
	else {
		shootEyesWait = random(60*2.5);
		if (x < noAttackX) openMouth = true;
	}
}

// Kill Player
if (oPlayer.x < x) {
	oPlayer.hp = 0;
	oPlayer.allowMovement = false;
}

if (place_meeting(x,y,oPlayer) and oPlayer.hurt > 0) {
	oPlayer.hsp = oPlayer.movespd * 2;	
}

// Dead
if (dead) {
	if (deadPercent == 0) {
		step = false;
		openMouth = true;
		shootEyes = false;
		xstart = x;
		ystart = y;
		depth = oPlayer.depth + 10;
		oBossLvl4Eyes.depth = depth-4;
		oBossLvl4Mouth.depth = depth-2;
	}
	deadPercent = ApproachFade(deadPercent,1,0.1,0.7);
	
	var _num = instance_number(oBossLvl4LightBeam);
	ScreenShake(_num/48*5+2,20);
	
	if (--deadWait <= 0 and _num < 64) {
		if (_num < 16) {
			var _index = _num % 2;
			var _pos = [[x+168,y-20],[x+96,y-24]];
			instance_create_depth(_pos[_index][0],_pos[_index][1],depth-8,oBossLvl4LightBeam);
			deadWait = 8;
		} else {
			var _x = random_range(bbox_left+32,bbox_right-32);	
			var _y = random_range(bbox_top+32,bbox_bottom-32);
			var _beam = instance_create_depth(_x,_y,depth-8,oBossLvl4LightBeam);
			_beam.image_angle = point_direction((bbox_right+bbox_left)/2,(bbox_bottom+bbox_top)/2,_x,_y) + random_range(-10,10);
			deadWait = 2;
		}
		
		if (_num > 30 and !instance_exists(oBossLvl4Outro)) {
			instance_create_depth(0,0,oPlayer.depth-5,oBossLvl4Outro);	
		}
	}
}