/// @desc 

enableLive;

var _time = oMusicController.thisBeat % 0.5;

if (counter <= 0) {
	if (_time < lastTime) {
		lastTime = _time;
		counter--;
		show_debug_message("G");
	}
}