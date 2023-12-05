/// @desc 

enableLive;

event_inherited();

if (--timer < 0 and instance_number(oBossLvl4HomingEye) < 5) {
	instance_create_depth(x,y,depth-1,oBossLvl4HomingEye);
	timer = 180;
}

// Eyes Shield
for(var i = 0; i < 6; i++) {
	eyes[i].x = x + lengthdir_x(48,360/6*i);
	eyes[i].y = y + lengthdir_y(48,360/6*i);
}