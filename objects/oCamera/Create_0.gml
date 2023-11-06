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
xTo = x;
yTo = y;