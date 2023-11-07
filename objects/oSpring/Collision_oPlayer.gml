/// @desc 

with(other) {
	dash = 0;
	vsp = jumpSpd;
	allowDash = true;
	hsp = 0;
}

image_speed = 1;
if (!audio_is_playing(snSpring)) audio_play_sound(snSpring, 1, false,1,0,random_range(0.8, 1.2));