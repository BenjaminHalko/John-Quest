/// @desc Update Camera

//Update destination
if(instance_exists(follow)) {
	xTo = follow.x;
	yTo = follow.y;
	boundary = instance_position(xTo,yTo,oCameraBoundary);
	if (boundary != noone) {
		xTo = clamp(xTo, boundary.bbox_left+viewWidthHalf+boundary.xOffset, boundary.bbox_right-viewWidthHalf+boundary.xOffset);
		yTo = clamp(yTo, boundary.bbox_top+viewHeightHalf+boundary.yOffset, boundary.bbox_bottom-viewHeightHalf+boundary.yOffset);
	}
} else boundary = noone;

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