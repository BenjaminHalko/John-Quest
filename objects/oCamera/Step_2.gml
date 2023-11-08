/// @desc Update Camera

//Update destination
if(instance_exists(follow)) {
	xTo = follow.x;
	yTo = follow.y;
	boundry = instance_position(xTo,yTo,oCameraBoundry);
	if (boundry != noone) {
		xTo = clamp(xTo, boundry.bbox_left+viewWidthHalf, boundry.bbox_right-viewWidthHalf);
		yTo = clamp(yTo, boundry.bbox_top+viewHeightHalf, boundry.bbox_bottom-viewHeightHalf);
	}
} else boundry = noone;

//Update Object Position
x += (xTo - x) / 12;
y += (yTo - y) / 12;

//Keep Camera center inside room
x = clamp(x, viewWidthHalf, room_width-viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height-viewHeightHalf);

//Screenshake
x += random_range(-shakeRemain,shakeRemain);
y += random_range(-shakeRemain,shakeRemain);

shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));

camera_set_view_pos(cam,x - viewWidthHalf,y - viewHeightHalf);