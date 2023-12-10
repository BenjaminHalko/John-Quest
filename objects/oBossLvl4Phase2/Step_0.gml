/// @desc 

enableLive;

event_inherited();

// Stepping
if (fall) {
	stepPercent = Approach(stepPercent,0,0.1);
	if (stepPercent == 0) {
		ScreenShake(5,15);
		fall = false;
		stepWait = 30;
		yStepBegin = y-30;
	}
	//x += 2;
} else if (--stepWait <= 0 and step) {
	stepPercent = Approach(stepPercent,1,0.02);
	if (stepPercent == 1) {
		yStepTarget = oCamera.y+20;
		fall = true;
	}
	//x += 1.5;
}
y = lerp(yStepTarget,yStepBegin,stepPercent);

// Mouth Fireball
if (keyboard_check_pressed(ord("M"))) openMouth = !openMouth; 
mouthYPercent = ApproachFade(mouthYPercent,openMouth,0.1,0.7);
mouthY = mouthYPercent * 64;

if (openMouth) {
	repeat(2) {
		var _len = 48;
		var _dir = 180 + random_range(-120,120);
		with(instance_create_depth(x+128+random_range(-2,2)+lengthdir_x(_len,_dir),y+72+random_range(-2,2)+lengthdir_y(_len,_dir),depth-2,oSquareParticle)) {
			image_blend = merge_color(#EE371B,#EEA01B,random(1));
			direction = _dir+180+random_range(-5,5);
			speed = random(4);
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
		} else if (--mouthWait <= 0) {
			if (_fireballLeft) {
				openMouth = false;
			} else {
				ScreenShake(5,10);
				fireball.go = true;
				mouthWait = 30;
			}
		}
	}
} else {
	createdFireball = false;
	mouthBurnPercent = 0.5;
}

// Shoot eyes
if (keyboard_check_pressed(ord("E"))) shootEyes = !shootEyes;
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
} else {
	eye1.x = x+96;
	eye1.y = y-30;
	eye1.scale = Approach(eye1.scale,0.8,0.05);
	if (eye1.scale == 0.8) {
		eye1.depth = depth-5;
		eye1.spd = 4;
		eye1.dir = point_direction(eye1.x,eye1.y,oPlayer.x,oPlayer.y)+random_range(-50,50);
		eye1 = noone;
	}
}
	
if (eye2 == noone) {
	if (shootEyes and eye1 != noone and eye1.scale > 0.4) {
		eye2 = instance_create_depth(x+162,y-26,depth-3,oBossLvl4ShieldEye);
		eye2.scale = 0;
		eye2.red = true;
		eye2.image_xscale = 0;
		eye2.image_yscale = 0;
		eye2.hp = 5;
	}
} else {
	eye2.scale = Approach(eye2.scale,0.8,0.05);
	eye2.x = x+162;
	eye2.y = y-26;
	if (eye2.scale == 0.8) {
		eye2.depth = depth-5;
		eye2.spd = 4;
		eye2.dir = point_direction(eye2.x,eye2.y,oPlayer.x,oPlayer.y)+random_range(-50,50);
		eye2 = noone;
	}
}

// Kill Player
if (oPlayer.x < x) {
	oPlayer.hp = 0;
	oPlayer.allowMovement = false;
}

if (place_meeting(x,y,oPlayer) and oPlayer.hurt > 0) {
	oPlayer.hsp = oPlayer.movespd;	
}