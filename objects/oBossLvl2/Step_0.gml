/// @desc 

enableLive;

depth = -bbox_bottom;





// Eyes
if (keyboard_check_pressed(ord("T"))) teleportPercentTarget = 1 - teleportPercentTarget;
teleportPercent = Approach(teleportPercent, teleportPercentTarget, 0.03);


var _teleportFade = animcurve_channel_evaluate(eyeExpandCurve, teleportPercent);
eyeSpinRotation -= 2 * max(0,_teleportFade);
for(var i = 0; i < 5; i++) {
	var _xNormal = eyes[i].x + x;
	var _yNormal = eyes[i].y + bbox_top;
	
	var _distance = 64;
	var _xSpin = x + lengthdir_x(_distance, eyeSpinRotation+360/5*i);
	var _ySpin = y + lengthdir_y(_distance, eyeSpinRotation+360/5*i);
	
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

image_alpha = 1 - max(0,_teleportFade);