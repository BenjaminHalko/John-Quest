/// @desc Set up camera
cam = view_camera[0];
viewWidthHalf = 480 * 0.5;
viewHeightHalf = 270 * 0.5;
follow = oPlayer;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

// Update coords to follows
snapToFollow = function() {
	x = follow.x;
	y = follow.y;
	boundary = instance_position(x,y,oCameraBoundary);
	if (boundary != noone) {
		x = clamp(x, boundary.bbox_left+viewWidthHalf+boundary.xOffset, boundary.bbox_right-viewWidthHalf+boundary.xOffset);
		y = clamp(y, boundary.bbox_top+viewHeightHalf+boundary.yOffset, boundary.bbox_bottom-viewHeightHalf+boundary.yOffset);
	}
	xTo = x;
	yTo = y;
}