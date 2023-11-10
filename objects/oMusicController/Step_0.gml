/// @desc 

thisBeat = audio_sound_get_track_position(music) / 60 * bpm;
var _beat = thisBeat % 1;
var _quickBeat = thisBeat % 0.25;

global.audioTick = _beat < lastBeat;
global.audioTickQuick= _quickBeat < lastQuickBeat;

lastBeat = _beat;
lastQuickBeat = _quickBeat;

global.audioBeat = floor(thisBeat);