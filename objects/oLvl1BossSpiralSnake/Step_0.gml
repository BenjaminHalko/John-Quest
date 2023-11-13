/// @desc 

if (--timer <= 0) {
	timer = 3;
	counter--;
	
	if (counter == 0) {
		image_alpha = 1;
		flash = 1;
	}
	
	depth--;
	
	if (counter < -10) {
		instance_destroy();	
	}
	
	if (!created and isOnScreen() and !oLvl1Boss.inBetweenPhases) {
		created = true;
		var _x = x + lengthdir_x(10, image_angle+rotation);
		var _y = y + lengthdir_y(10, image_angle+rotation);
		with(instance_create_depth(_x, _y, depth, oLvl1BossSpiralSnake)) {
			rotation = other.rotation;
			image_angle = rotation + other.image_angle;
		}
	}
}

image_alpha = Approach(image_alpha,1,0.02);
flash = Approach(flash,0,0.05);

image_xscale = 0.5 + flash / 2;
image_yscale = image_xscale;

if (place_meeting(x,y,oPlayer) and image_alpha == 1) {
	oPlayer.hurtPlayer();	
}