/// @desc 

enableLive;

event_inherited();

timer = 0;
count = 0;

eyes = [];
eyeRotation = 0;

for (var i = 0; i < 6; i++) {
	array_push(eyes,instance_create_depth(x,y,depth-1,oBossLvl4ShieldEye));
}