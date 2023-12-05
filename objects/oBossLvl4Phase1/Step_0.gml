/// @desc 

enableLive;

event_inherited();

if (--timer < 0 and count < 5) {
	instance_create_depth(x,y,depth-1,oBossLvl4HomingEye);
	timer = 10;
	count++;
}

if (instance_number(oBossLvl4HomingEye) == 0) count = 0;

// Eyes Shield
eyeRotation -= 2;
for(var i = 0; i < 6; i++) {
	eyes[i].x = x + lengthdir_x(32,360/6*i+eyeRotation);
	eyes[i].y = y + lengthdir_y(32,360/6*i+eyeRotation);
}