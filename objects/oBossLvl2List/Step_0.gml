/// @desc 

if (go) {
	accel += 0.002;
	percent = Approach(percent,1,accel);
	if (percent == 1) {
		oPlayer.flash = 0.8;
		oPlayer.flashCol = [1,1,1];
		audio_play_sound(snItemGet,1,false);
		instance_destroy();
	}
}

y = lerp(ystart,oPlayer.y-8,percent) + Wave(-6,6,2,0);
x = lerp(xstart,oPlayer.x,percent);