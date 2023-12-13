/// @desc 

percent = Approach(percent, leading, transitionSpd);
if (percent == 1) {
	audio_stop_all();
	room_goto(roomTo);	
} else if (percent == 0) {
	if (behindPlayer) {
		oPlayer.changeDepth = true;
	}
	instance_destroy();	
}