/// @desc 

enableLive;

if (oLvl1Boss.inBetweenPhases) {
	image_alpha -= 0.05;
	if (image_alpha <= 0) {
		instance_destroy();	
	}
} else {
	if (global.audioTick) {
		counter--;
		if (counter == 0) {
			var _x = x + lengthdir_x(sprite_height/2,image_angle+90);
			var _y = y + lengthdir_y(sprite_height/2,image_angle+90);
			with(instance_create_layer(_x,_y,layer,oLvl1BossCrusher)) {
				targetYscale = other.image_yscale;
				image_angle = other.image_angle;
				fade = other.id;
			}
		}
	}
	image_alpha += 0.005;
}