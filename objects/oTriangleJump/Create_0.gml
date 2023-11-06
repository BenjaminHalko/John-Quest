/// @desc 

enableLive;

outlineRotation = random(360);
collected = false;
breakPercent = 0;
breakCurvePercent = 0;
hoverPercent = 0;
hoverCurvePercent = 0;

disappearCurve = animcurve_get_channel(TriangleJumpCurve, "disappear");
reappearCurve = animcurve_get_channel(TriangleJumpCurve, "reappear");
hoverCurve = animcurve_get_channel(TriangleJumpCurve, "hover");

collect = function() {
	if (collected) return false;
	collected = true;
	repeat(25) {
		with(instance_create_layer(x,y,layer,oTriangleParticle)) {
			direction = random(360);
			speed = random_range(0.5,3);
			image_blend = merge_color(c_white, #65FFFF, random(1));
			image_angle = random(360);
			radius = 8;
			spd = random_range(0.04, 0.07);
			ScreenShake(5, 10);
		}
	}
	alarm[0] = 60;
	
	return true;
}