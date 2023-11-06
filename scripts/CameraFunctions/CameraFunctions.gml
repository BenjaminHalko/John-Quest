function ScreenShake(_magnitude,_frames) {
	with(oCamera) {
		if(_magnitude > shakeRemain) {
			shakeMagnitude = _magnitude;
			shakeRemain = _magnitude;
			shakeLength = _frames;
		}
	}
}

function isOnScreen() {
	var _camX1 = oCamera.x-oCamera.viewWidthHalf;
	var _camY1 = oCamera.y-oCamera.viewHeightHalf;
	var _camX2 = oCamera.x+oCamera.viewWidthHalf;
	var _camY2 = oCamera.y+oCamera.viewHeightHalf;
	return (bbox_left <= _camX2 and bbox_right >= _camX1 and bbox_top <= _camY2 and bbox_bottom >= _camY1);
}