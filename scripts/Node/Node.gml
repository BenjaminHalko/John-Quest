/// @desc A node for Level 3
/// @param {real} east
/// @param {real} north
/// @param {real} west
/// @param {real} south
function Node(_east, _north, _west, _south) constructor {
	image = [_east, _north, _west, _south];
	nextNode = array_create(4, -1);
	hasPiece = -1;
	pieceDir = -1;
	twoWay = false;
	
	for(var i = 0; i < 4; i++) {
		if (image[i] == -2) twoWay = true;
		if (image[i] >= 0) {
			nextNode[i] = image[i];	
		}
		if (image[i] < -2) {
			hasPiece = image[i] * -1 - 3;
			pieceDir = i;
		}
	}
}