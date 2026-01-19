/// @desc 

for(var i = 0; i < array_length(stars); i++) {
	stars[i].alpha += stars[i].spd;
	if (stars[i].alpha >= 2) {
		stars[i].x = irandom(480);	
		stars[i].y = irandom(270);
		stars[i].spd = random_range(0.001,0.01);
		stars[i].alpha = 0;
	}
}

if (!surface_exists(surf)) surf = surface_create(surfWidth,surfHeight);

// Scroll Credits
if (audio_is_playing(mCredits)) scrollPercent = min(1,audio_sound_get_track_position(music) / musicLen);
else scrollPercent = 1;

if (scrollPercent == 1) {
	if (InputPressed(INPUT_VERB.ACCEPT)) Transition(rTitle);
}