/// @desc

var _keyUp = keyboard_check(vk_up);
var _keyDown = keyboard_check(vk_down);
var _keyRight = keyboard_check(vk_right);
var _keyLeft = keyboard_check(vk_left);
var _keyJump = keyboard_check_pressed(vk_space);
var _keyDash = keyboard_check_pressed(vk_shift);
var _move = _keyRight-_keyLeft;
var _duck = _keyUp - _keyDown;

if (respawnPercent == 1) {
	if dash == 0 {
		if autoMove == undefined {
			if _move != 0 {
				dirFacing = _move;
				walkWave += 1/10;
			} else walkWave = pi*1.5;
			hsp = ApproachFade(hsp,_move*(moveSpd),0.8,0.85);
		} else {
			if abs(x-autoMove) <= moveSpd+5 {
				x = autoMove;
				hsp = 0;
				hsp_final = 0;
				hsp_f = 0;
				walkWave = pi*1.5;
				
			} else {
				hsp = moveSpd*sign(autoMove-x);
				walkWave += 1/10;
			}
			
			_move = 1;
			dirFacing = 1;
		}
		vsp += grv;
		
		if tempHurt > 0 {
			hsp = 0;
			vsp = 0;
		}
		
		vsp = min(vsp,10);
		
		//Jump
		if(_keyJump) jumpTimer = 10;

		if(canJump-- > 0 && jumpTimer > 0) {
			vsp = jumpSpd;
			canJump = 0;
			jumpTimer = 0;
		}
		jumpTimer--;
	
		if _keyDash and allowDash {
			dash = 12;
			flash = 1;
			allowDash = false;
			
			// Calc dash dir
			var _xDir = dirFacing;
			var _yDir = -_duck;
			if (_yDir != 0) {
				_xDir = _move;	
			}
			dashDir = point_direction(0,0,_xDir,_yDir);
		}
	} else {
		dash--;
		hsp = lerp(moveSpd,dashSpd,dash/12)*dirFacing;
		vsp = 0;
		vsp_final = 0;
	}
	
	//Spd Calculations
	hsp_final = hsp + hsp_f;
	hsp_f = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
	hsp_final -= hsp_f;
 
	vsp_final = vsp + vsp_f;
	vsp_f = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
	vsp_final -= vsp_f;

	//Collide horizontal
	if (place_meeting(x+hsp_final,y,global.collisionMap)) {
		while(!place_meeting(x+sign(hsp_final),y,global.collisionMap)) x += sign(hsp_final);
		hsp_final = 0;
		hsp = 0;
		hsp_f = 0;
	}
	
	x += hsp_final;
	
	// Collide vertical
	if (place_meeting(x,y+vsp_final,global.collisionMap)) {
		while(!place_meeting(x,y+sign(vsp_final),global.collisionMap)) y += sign(vsp_final);
		vsp = 0;
		vsp_f = 0;
		vsp_final = 0;
		allowDash = true;
		canJump = 10;
	}
	
	y += vsp_final;

	//Animation
	if dash == 0 {
		topShiftPercent = ApproachFade(topShiftPercent,vsp_final == 0,0.1,0.7);	
		yscale = ApproachFade(yscale,max(0.5,(vsp_final != 0 ? vsp/-4 : (_move != 0 and vsp_final == 0 ? -abs(hsp)/moveSpd*lerp(0.05,0.4,0.5+sin(walkWave*pi)/2) : _duck*0.4))+1),0.04+0.15*(vsp_final <= 0),0.7);
	} else {
		topShiftPercent = 0.6;
		yscale = ApproachFade(yscale,lerp(1,0.3,dash/20),0.4,0.7);
	}
} else {
	yscale = ApproachFade(yscale,1,0.05,0.7);
	topShiftPercent = ApproachFade(topShiftPercent,0,0.1,0.7);
	dirFacing = respawnScale;
	respawnPercent = ApproachFade(respawnPercent,1,0.04,0.7);
	if respawnPercent > 0 {
		x = lerp(xstart,respawnX,respawnPercent);
		y = lerp(ystart,respawnY-Wave(12,24,0.5,0),respawnPercent);
	} else {
		yscale = random_range(0.5,1.8);
	}
}

if tempHurt > 0 yscale = random_range(0.5,1.8);

tempHurt = Approach(tempHurt,0,1);
xscale = ApproachFade(xscale,dirFacing,0.2,0.7);

flash = ApproachFade(flash,0,0.1,0.8);

if y > room_height hurtPlayer();