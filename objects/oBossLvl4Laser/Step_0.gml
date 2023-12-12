/// @desc 

// Inherit the parent event
event_inherited();

image_xscale = point_distance(eye1.x,eye1.y,eye2.x,eye2.y) / 16 * oBossLvl4Phase1.hexagonPercent;
image_angle = point_direction(eye1.x,eye1.y,eye2.x,eye2.y);
x = lerp(eye1.x,(eye1.x+eye2.x)/2,oBossLvl4Phase1.hexagonPercent);
y = lerp(eye1.y,(eye1.y+eye2.y)/2,oBossLvl4Phase1.hexagonPercent);

if (destroy or hp <= 0) {
	repeat(20 * image_xscale) {
		var _len = random(16*image_xscale);
		var _x = eye1.x + lengthdir_x(_len,image_angle);
		var _y = eye1.y + lengthdir_y(_len,image_angle);
		
		with(instance_create_depth(_x+random_range(-1,1),_y+random_range(-1,1),depth,oTriangleParticle)) {
			image_blend = choose(#CC0021,#B2001D,#FF0033,#E5002E,#E50008);
			image_angle = random(360);
			direction = other.image_angle + random_range(20,160) * choose(1,-1);
			spd = 0.05;
			speed = random(2);
		}
	}
	audio_play_sound(snBreak,1,false,0.5);
	instance_destroy();	
}