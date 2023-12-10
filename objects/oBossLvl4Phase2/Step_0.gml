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
		with(instance_create_depth(x+128+lengthdir_x(_len,_dir),y+72+lengthdir_y(_len,_dir),depth-2,oSquareParticle)) {
			image_blend = merge_color(#EE371B,#EEA01B,random(1));
			direction = _dir+180+random_range(-5,5);
			speed = random(3);
			spd = 0.05;
		}
	}
	if (mouthYPercent == 1) {
		if (!createdFireball) {
			createdFireball = true;
			mouthWait = 30;
			fireball = instance_create_depth(x+124,y+74,depth-1,oBossLvl4Fireball);
		} else if (--mouthWait <= 0) {
			if (!instance_exists(fireball) or fireball.go) {
				openMouth = false;
			} else {
				fireball.go = true;
				mouthWait = 30;
			}
		}
	}
} else {
	createdFireball = false;	
}

// Kill Player
if (oPlayer.x < x) {
	oPlayer.hp = 0;
	oPlayer.allowMovement = false;
}

if (place_meeting(x,y,oPlayer) and oPlayer.hurt > 0) {
	oPlayer.hsp = oPlayer.movespd;	
}