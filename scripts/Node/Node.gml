/// @desc A node for Level 3
/// @param {real} east
/// @param {real} north
/// @param {real} west
/// @param {real} south
/// @param {real} x
/// @param {real} y
/// @param {real} floor
function Node(_east, _north, _west, _south, _x, _y, _floor) constructor {
	image = [_east, _north, _west, _south];
	nextNode = array_create(4, -1);
	hasPiece = -1;
	pieceDir = -1;
	twoWay = false;
    x = _x;
    y = _y;
    flr = _floor;
	
	for(var i = 0; i < 4; i++) {
		if (image[i] == -2) twoWay = true;
		if (image[i] >= 0) {
			nextNode[i] = image[i];	
		}
		if (image[i] < -2) {
			hasPiece = 5 - image[i] * -1;
			pieceDir = i;
		}
	}
}