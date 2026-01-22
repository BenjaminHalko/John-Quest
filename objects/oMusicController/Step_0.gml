/// @desc 

if (!audio_is_playing(music)) exit;

thisBeat = audio_sound_get_track_position(music) / 60 * bpm;
var _beat = thisBeat % 1;
global.audioTick = _beat < lastBeat;
lastBeat = _beat;
global.audioBeat = floor(thisBeat);