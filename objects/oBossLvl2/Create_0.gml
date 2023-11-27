/// @desc 

enableLive;

hp = 200;
maxHp = hp;

eyeSpinRotation = 0;
teleportPercent = 0;
teleportPercentTarget = 0;

eyeExpandCurve = animcurve_get_channel(BossLvl2Curves, "eyeExpand");

eyes = [
	{ x: 0, y: 2, waveOffset: 0.9},
	{ x: -7, y: -1, waveOffset: 0.2 },
	{ x: 6, y: -1, waveOffset: 0.5 },
	{ x: -4, y: -5, waveOffset: 0.3 },
	{ x: 3, y: -5, waveOffset: 0.7 }
];
for(var i = 0; i < 5; i++) {
	eyes[i].obj = instance_create_layer(eyes[i].x+x,eyes[i].y+bbox_top,layer,oBossLvl2Eye);
}