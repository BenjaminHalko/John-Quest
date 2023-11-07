/// @desc Update Camera

//Update destination
if(instance_exists(follow)) {
	xTo = follow.x;
	yTo = follow.y;
	var _boundry = instance_position(xTo,yTo,oCameraBoundry);
	if (_boundry != noone) {
		xTo = clamp(xTo, _boundry.bbox_left+viewWidthHalf, _boundry.bbox_right-viewWidthHalf);
		yTo = clamp(yTo, _boundry.bbox_top+viewHeightHalf, _boundry.bbox_bottom-viewHeightHalf);
	}
}

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