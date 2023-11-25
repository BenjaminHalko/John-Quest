/// @desc 

if (inCave != global.inCave) {
	audio_resume_sound(global.inCave ? caveMusic : music);
	audio_sound_gain(music, 1-global.inCave, 800-global.inCave*500);
	audio_sound_gain(caveMusic, global.inCave, 800-!global.inCave*500);
	inCave = global.inCave;
	Save("lvl2","inCave",global.inCave);
}

if keyboard_check_pressed(vk_control) global.inCave = !global.inCave;