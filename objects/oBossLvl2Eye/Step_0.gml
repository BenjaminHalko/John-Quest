/// @desc 

depth = -bbox_bottom - oBossLvl2.yEyeOffset/2;

if (oBossLvl2.eyeExpandPercent > 0.4 or oBossLvl2.dead) depth -= oBossLvl2.yEyeOffset/2;

if (size == 0) {
	image_xscale = xscale;
	image_yscale = yscale;
	sprite_index = sBossLvl2EyeSmall;
} else {
	image_xscale = (0.5+size/2) * xscale;
	image_yscale = (0.5+size/2) * yscale;
	image_yscale = (0.5+size/2) * yscale;
	sprite_index = sBossLvl2Eye;
}

image_blend = merge_color(#888888,c_white,min(size+oBossLvl2.deadPercent,1));

if (place_meeting(x,y,oPlayer) and !oBossLvl2.intro and oBossLvl2.eyeExpandPercent-(!oBossLvl2.teleportAppear) > 0.5 and !oBossLvl2.dead and !oBossLvl2.shouldDie) {
	oPlayer.hurtPlayer(point_direction(x,y,oPlayer.x,oPlayer.y),32,0.25);
}