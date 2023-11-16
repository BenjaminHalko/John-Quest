/// @desc 

percent = Approach(percent, leading, transitionSpd);
if (percent == 1) {
	room_goto(roomTo);	
} else if (percent == 0) {
	instance_destroy();	
}