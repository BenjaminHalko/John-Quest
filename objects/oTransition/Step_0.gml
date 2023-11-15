/// @desc 

percent = Approach(percent, leading, transitionSpd);
if (percent == 1) {
	if (room != roomTo) room_goto(roomTo);	
} else if (percent == 0) {
	instance_destroy();	
}