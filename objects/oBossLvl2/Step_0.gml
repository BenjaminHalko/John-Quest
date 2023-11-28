/// @desc 

enableLive;

depth = -y;

if (keyboard_check_pressed(ord("T"))) isTeleporting = 1 - isTeleporting;

// Intro
if (intro) {
	if (disappearPercent == 0 and --introWait <= 0) {
		intro = false;
	}
}

#region Teleporting
if (isTeleporting) {
	if (eyeExpandPercent == 1.5-teleportAppear*0.5 and (disappearPercent == 1.5 or eyeX != x or eyeY != y) and !intro) {
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
		eyeSpinRotationDir = -eyeSpinRotationDir;
		teleportAppear = false;
		teleportAppearWait = 30;
		xstart = x;
		ystart = y;
	}
}
#endregion

// Damage
if (disappearPercent == 0 and place_meeting(x,y,oPlayer)) {
	oPlayer.hurtPlayer(point_direction(x,y,oPlayer.x,oPlayer.y),32,0.25);
}
enemyAttackable = (eyeExpandPercent == 0);

#region Eyes
var _teleportFade = animcurve_channel_evaluate(eyeExpandCurve, max(0,eyeExpandPercent-0.5*(!teleportAppear)));
eyeSpinRotation -= 2 * (3-max(0,_teleportFade)*2) * eyeSpinRotationDir;
for(var i = 0; i < 5; i++) {
	var _xNormal = eyes[i].x + eyeX;
	var _yNormal = eyes[i].y + eyeY - yEyeOffset;
	
	var _distance = 88;
	if (intro) _distance += 500 * disappearPercent;
	var _xSpin = eyeX + lengthdir_x(_distance, eyeSpinRotation+360/5*i);
	var _ySpin = eyeY - yEyeOffset + lengthdir_y(_distance, eyeSpinRotation+360/5*i);
	
	if (i != 0) {
		_xNormal += Wave(-1,1,1+eyes[i].waveOffset,eyes[i].waveOffset) * (1-_teleportFade);
		_yNormal += Wave(-1,1,1+eyes[i].waveOffset*1.2,eyes[i].waveOffset*1.5) * (1-_teleportFade);
		eyes[i].obj.size = clamp(_teleportFade*3,0,1);
		eyes[i].obj.image_angle = Wave(-16,16,2,eyes[i].waveOffset) * (1-_teleportFade);
		eyes[i].obj.image_angle += Wave(-16,16,1,eyes[i].waveOffset) * _teleportFade;
		eyes[i].obj.xscale = lerp(1,Wave(1.2,0.8,0.5,eyes[i].waveOffset),_teleportFade);
		eyes[i].obj.yscale = lerp(1,Wave(0.8,1.2,0.5,eyes[i].waveOffset),_teleportFade);
		eyes[i].obj.x = lerp(_xNormal, _xSpin, _teleportFade);
		eyes[i].obj.y = lerp(_yNormal, _ySpin, _teleportFade);
	} else {
		eyes[i].obj.xscale = lerp(Wave(0.7,1.06,1,0),1,_teleportFade);
		eyes[i].obj.yscale = lerp(Wave(0.9,1.2,1,0.3),1,_teleportFade);
		eyes[i].obj.xscale *= lerp(1,Wave(1.2,0.8,0.5,eyes[i].waveOffset),_teleportFade);
		eyes[i].obj.yscale *= lerp(1,Wave(0.8,1.2,0.5,eyes[i].waveOffset),_teleportFade);
		eyes[i].obj.image_angle = Wave(-16,16,1,eyes[i].waveOffset) * _teleportFade;
		eyes[i].obj.x = lerp(_xNormal, _xSpin, max(0,_teleportFade));
		eyes[i].obj.y = lerp(_yNormal, _ySpin, max(0,_teleportFade));
	}
}
#endregion

// Values
eyeExpandPercent = Approach(min(1.5-0.5*teleportAppear,eyeExpandPercent), (intro or isTeleporting)*(1.5 - teleportAppear*0.5), 0.03);
disappearPercent = Approach(disappearPercent,(!teleportAppear and _teleportFade > 0) * 1.5,0.03-0.015*intro);
flash = max(flash-0.1,0);

// Surface
if (!surface_exists(surf)) surf = surface_create(sprite_width,sprite_height);

// Particles
if (eyeExpandPercent != 0 and (!teleportAppear or eyeExpandPercent == 1) and disappearPercent < 1) or intro {
	with(instance_create_depth(x+random_range(-sprite_width/2,sprite_width/2),y+random_range(-3,3),depth+1,oSquareParticle)) {
		direction = random(180);
		speed = 1;
		spd = 0.035;
		image_angle = random(360);
		image_blend = merge_color(#BB00FF,#5500FF,random(360));
		depth = -y;
		radius = 2;
	}
}