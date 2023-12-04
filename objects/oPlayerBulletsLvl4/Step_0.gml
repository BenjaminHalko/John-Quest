/// @desc 

colNum = (colNum+1) % 3;
image_blend = cols[colNum];


var _boss = collision_rectangle(bbox_left,bbox_top,bbox_left+speed,bbox_bottom,[oBossLvl1Small, oBossLvl1],false,false);
if (_boss != noone) {
	_boss.flash = 1;
	ScreenShake(2, 2);
	instance_destroy();
}