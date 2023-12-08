/// @desc

if (activated and image_index != 1) {
	image_index = 1;
	with(oDoor) {
		if (doorNumber == other.doorNumber) {
			activated = true;	
		}
	}
}