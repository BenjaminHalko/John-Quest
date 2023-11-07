/// @desc 

var _thisBeat = audio_sound_get_track_position(music) / 60 * bpm;
var _beat = _thisBeat % 1;
global.audioTick = _beat < lastBeat;
lastBeat = _beat;
global.audioBeat = floor(_thisBeat);