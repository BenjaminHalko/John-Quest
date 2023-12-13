/// @desc 

if (os_type != os_operagx) {
	if (room == rTitle) {
		game_end();
	} else {
		Transition(rTitle);
	}
}