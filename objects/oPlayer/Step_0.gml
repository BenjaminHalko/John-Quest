/// @desc

enableLive;

var _keyUp = keyboard_check(vk_up);
var _keyDown = keyboard_check(vk_down);
var _keyRight = keyboard_check(vk_right);
var _keyLeft = keyboard_check(vk_left);
var _keyDash = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_shift);
var _move = _keyRight-_keyLeft;
var _duck = _keyUp - _keyDown;

if (respawnPercent == 1) {
	if dash == 0 {
		if autoMove == undefined {
			if _move != 0 {
				dirFacing = _move;
				walkWave += 1/10;
			} else if (_duck != 0 and boss) {
				walkWave += 1/10;
			} else walkWave = pi*1.5;
			hsp = ApproachFade(hsp,_move*(moveSpd+1*boss),0.8,0.85-0.2*boss);
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
		
		if (!boss) vsp += grv;
		else if (autoMove == undefined) {
			vsp = ApproachFade(vsp,-_duck*(moveSpd+1),0.8,0.75);	
		}
		
		vsp = min(vsp,10);
		
		if (autoMove == undefined) {
			// Jumping
			canJump--;
			var _triJump = instance_place(x,y,oTriangleJump);
			if (_triJump != noone) {
				savedJumpID = _triJump;
				canJump = 3;
			}
	
			// Dashing
			if _keyDash {
				if canJump > 0 {
					if(savedJumpID.collect()) {
						vsp = jumpSpd;
						allowDash = true;
						rotation = -10;
					}
				} else if (allowDash or boss) {
					dash = 10;
					flash = 1;
					allowDash = false;
					if (boss) {
						dashDir = point_direction(0,0,_move,-_duck);
					} else {
						dashDir = 180 * (dirFacing == -1);
					}
				}
			}
		}
	} else {
		dash--;
		var _spd = lerp(moveSpd,dashSpd,dash/10);
		hsp = lengthdir_x(_spd,dashDir);
		vsp = lengthdir_y(_spd,dashDir);
	}
	
	//Spd Calculations
	hsp_final = hsp + hsp_f;
	hsp_f = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
	hsp_final -= hsp_f;
 
	vsp_final = vsp + vsp_f;
	vsp_f = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
	vsp_final -= vsp_f;
	
	// Horizontal Semi Solids
	var _semi = instance_place(x+hsp_final,y,pSemiSolid);
	if (_semi != noone) {
		if (place_meeting(x,y,_semi)) or (_semi.image_angle == 270 and x-8 < _semi.x and hsp_final >= 0) or (_semi.image_angle == 90 and x+8 > _semi.x and hsp_final <= 0) or (_semi.image_angle != 90 and _semi.image_angle != 270) {
			_semi = noone;
		}
	}

	//Collide horizontal
	var _horiColliders = [global.collisionMap, _semi];
	if (place_meeting(x+hsp_final,y,_horiColliders)) {
		while(!place_meeting(x+sign(hsp_final),y,_horiColliders)) x += sign(hsp_final);
		hsp_final = 0;
		hsp = 0;
		hsp_f = 0;
	}
	
	x += hsp_final;
	
	// Vertical Semi Solids
	_semi = instance_place(x,y+vsp_final,pSemiSolid);
	if (_semi != noone) {
		if (place_meeting(x,y,_semi)) or (_semi.image_angle == 0 and y+8 > _semi.y and vsp_final <= 0) or (_semi.image_angle == 180 and y-8 < _semi.y and vsp_final >= 0) or (_semi.image_angle != 0 and _semi.image_angle != 180) {
			_semi = noone;
		}
	}
	
	// Collide vertical
	var _vertColliders = [global.collisionMap, _semi];
	if (place_meeting(x,y+vsp_final,_vertColliders)) {
		while(!place_meeting(x,y+sign(vsp_final),_vertColliders)) y += sign(vsp_final);
		if (vsp_final > 0) {
			allowDash = true;
		}
		vsp = 0;
		vsp_f = 0;
		vsp_final = 0;
	}
	
	y += vsp_final;

	//Animation
	if dash == 0 {
		topShiftPercent = ApproachFade(topShiftPercent,vsp_final == 0,0.1,0.7);	
		if rotation != 0 {
			rotation = ApproachFade(rotation,-360,20,0.6);
			if rotation <= -359.5 rotation = 0;
		}
		yscale = ApproachFade(yscale,max(0.5,(vsp_final != 0 and !boss ? vsp/-4 : ((_move != 0 or (_duck != 0 and boss)) and vsp_final == 0 ? -abs(hsp)/moveSpd*lerp(0.05,0.4,0.5+sin(walkWave*pi)/2) : _duck*0.4))+1),0.08+0.15*(vsp_final <= 0),0.7);
	} else {
		topShiftPercent = 0.6;
		rotation = 0;
		yscale = ApproachFade(yscale,lerp(1,0.3,dash/10),0.4,0.7);
	}
} else {
	rotation = 0;
	yscale = ApproachFade(yscale,1,0.05,0.7);
	topShiftPercent = ApproachFade(topShiftPercent,0,0.1,0.7);
	dirFacing = respawnScale;
	respawnPercent = ApproachFade(respawnPercent,1,0.05,0.6);
	if respawnPercent > 0 {
		x = round(lerp(xstart,respawnX,respawnPercent));
		y = round(lerp(ystart,respawnY-Wave(12,24,0.5,0),respawnPercent));
	} else {
		yscale = random_range(0.5,1.8);
	}
}

if tempHurt > 0 yscale = random_range(0.5,1.8);

tempHurt = Approach(tempHurt,0,1);
if (!boss) {
	xscale = ApproachFade(xscale,dirFacing,0.2,0.7);
} else xscale = 1;

flash = ApproachFade(flash,0,0.1,0.8);

if y > room_height or place_meeting(x,y,pHurt) hurtPlayer();
else if (boss and respawnPercent == 1) {
	var _bomb = instance_place(x,y,oLvl1BossBomb);
	if (_bomb != noone and _bomb.targetPercent == 1) {
		hurtPlayer();
		var _dir = point_direction(_bomb.x,_bomb.y,x,y);
		hsp = lengthdir_x(12, _dir);
		vsp = lengthdir_y(12, _dir);
	}
}

// Check if below camera boundry
if (boss) {
	if (oCamera.boundry != noone and autoMove == undefined) {
		if (x > oCamera.boundry.bbox_right-8 or x < oCamera.boundry.bbox_left+8) {
			x = clamp(x, oCamera.boundry.bbox_left+8, oCamera.boundry.bbox_right-8);
			hsp_final = 0;
			hsp = 0;
			hsp_f = 0;
		}
		if (y > oCamera.boundry.bbox_bottom-8 or y < oCamera.boundry.bbox_top+8) {
			y = clamp(y, oCamera.boundry.bbox_top+8, oCamera.boundry.bbox_bottom-8);
			vsp_final = 0;
			vsp = 0;
			vsp_f = 0;
		}
	}
} else if (!place_meeting(x,y,oCameraSafeFall)) {
	if (oCamera.boundry != noone) {
		if (y >= oCamera.boundry.bbox_bottom-8) {
			y = oCamera.boundry.bbox_bottom-8;
			hurtPlayer();
		}
	}
}