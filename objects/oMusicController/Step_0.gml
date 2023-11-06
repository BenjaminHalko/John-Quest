/// @desc 

var _currentBeat = audio_sound_get_track_position(music) / 60 * 130;
var _beat = _currentBeat % 1;
global.audioTick = _beat < lastBeat;
lastBeat = _beat;
global.audioBeat = floor(_currentBeat % 8);