/// @desc 

enableLive;

// Inherit the parent event
event_inherited();

image_xscale = point_distance(eye1.x,eye1.y,eye2.x,eye2.y) / 16 * oBossLvl4Phase1.hexagonPercent;
image_angle = point_direction(eye1.x,eye1.y,eye2.x,eye2.y);
x = lerp(eye1.x,(eye1.x+eye2.x)/2,oBossLvl4Phase1.hexagonPercent);
y = lerp(eye1.y,(eye1.y+eye2.y)/2,oBossLvl4Phase1.hexagonPercent);

if (destroy) {
	instance_destroy();	
}