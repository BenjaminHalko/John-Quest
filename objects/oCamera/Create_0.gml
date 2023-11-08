/// @desc Set up camera
cam = view_camera[0];
viewWidthHalf = 480 * 0.5;
viewHeightHalf = 270 * 0.5;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

// Change follow based on room
switch(room) {
	case rLvl1: default: {
		follow = oPlayer;
	} break;
}

// Update coords to follows
x = follow.x;
y = follow.y;
var _boundry = instance_position(x,y,oCameraBoundry);
if (_boundry != noone) {
	x = clamp(x, _boundry.bbox_left+viewWidthHalf, _boundry.bbox_right-viewWidthHalf);
	y = clamp(y, _boundry.bbox_top+viewHeightHalf, _boundry.bbox_bottom-viewHeightHalf);
}
xTo = x;
yTo = y;