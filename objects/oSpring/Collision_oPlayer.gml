/// @desc 

if (other.respawnPercent == 1) {
	with(other) {
		dash = 0;
		allowDash = true;
		if (other.image_angle != 0) {
			hsp = 12 * other.image_xscale * -sign(other.image_angle);
			vsp = -5;
		} else {
			vsp = jumpSpd;
			hsp = 0;
		}
	}

	image_speed = 1;
	if (point_distance(x,y,global.springSoundSourceX,global.springSoundSourceY) > 32 or !audio_is_playing(snSpring)) {
		global.springSoundSourceX = x;
		global.springSoundSourceY = y;
		audio_play_sound(snSpring, 1, false,1,0,random_range(0.8, 1.2));
	}
}