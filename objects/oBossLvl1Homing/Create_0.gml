/// @desc 

startBeat = oMusicController.thisBeat;
time = 2 - (oMusicController.thisBeat % 2 - global.audioBeat % 2);

var _boundary = oCamera.boundary;
var _x1 = _boundary.bbox_left-4;
var _x2 = _boundary.bbox_right+4;
var _y1 = _boundary.bbox_top-4;
var _y2 = _boundary.bbox_bottom+4;

dir = point_direction(x,y,oPlayer.x,oPlayer.y);
var _slope = dtan(dir);

var _yLeft = y + (x - _x1) * _slope;
var _yRight = y + (x - _x2) * _slope;
var _xTop = x + (y - _y1) / _slope;
var _xBottom = x + (y - _y2) / _slope;

targetX = x;
targetY = y;
if (_y1 <= _yLeft and _yLeft <= _y2 and (dir + 90) % 360 > 180) {
	targetX = _x1;
	targetY = _yLeft;
} else if (_y1 <= _yRight and _yRight <= _y2 and (dir + 90) % 360 < 180) {
	targetX = _x2;
	targetY = _yRight;
} else if (_x1 <= _xTop and _xTop <= _x2 and dir % 360 < 180) {
	targetX = _xTop;
	targetY = _y1;
} else {
	targetX = _xBottom;
	targetY = _y2;
}

trailNum = 0;
flash = 1;