/// @desc Set up camera
cam = view_camera[0];
viewWidthHalf = 480 * 0.5;
viewHeightHalf = 270 * 0.5;
follow = oPlayer;
xOffset = 0;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

if (room == rLvl3) {
	x = room_width/2;
	y = room_height/2;
	follow = noone;
}

// Update coords to follows
boundary = noone;
snapToFollow = function() {
	if (instance_exists(follow)) {
		x = follow.x;
		y = follow.y;
	}
	boundary = instance_position(x,y,oCameraBoundary);
	if (boundary != noone) {
		x = clamp(x, boundary.bbox_left+viewWidthHalf+max(0,boundary.xOffset), boundary.bbox_right-viewWidthHalf+min(0,boundary.xOffset));
		y = clamp(y, boundary.bbox_top+viewHeightHalf+max(0,boundary.yOffset), boundary.bbox_bottom-viewHeightHalf+min(0,boundary.yOffset));
	}
	xTo = x;
	yTo = y;
}