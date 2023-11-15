/// @desc 

bpm = 140;
music = audio_play_sound(mLvl1Music,1,true);
audio_sound_loop_start(music, 60 / bpm * 51 * 4);
audio_sound_loop_end(music, 60 / bpm * 57 * 4);
lastBeat = 0;
thisBeat = 0;
global.audioTick = false;
global.audioBeat = 0;