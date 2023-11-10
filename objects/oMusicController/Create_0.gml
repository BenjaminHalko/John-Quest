/// @desc 

bpm = 140;
music = audio_play_sound(mLvl1Music,1,true);
lastBeat = 0;
lastQuickBeat = 0;

thisBeat = 0;

global.audioTick = false;
global.audioTickQuick = false;

global.audioBeat = 0;