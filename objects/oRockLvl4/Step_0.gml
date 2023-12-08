/// @desc

vsp += 0.06;

if (hsp != 0 or vsp != 0) {
	var _xStart = x;
	var _yStart = y;
	MoveAndCollide(hsp,vsp,0,-sign(vsp));
	var _testX1 = x;
	var _testY1 = y;
	repeat(3) MoveAndCollide(hsp,vsp,0,-sign(vsp));
	var _dist = point_distance(x,y,_xStart,_yStart);
	x = _xStart;
	y = _yStart;
	MoveAndCollide(hsp,vsp,-sign(hsp),0);
	var _testX2 = x;
	var _testY2 = y;
	repeat(3) MoveAndCollide(hsp,vsp,-sign(hsp),0);
	if (point_distance(x,y,_xStart,_yStart) < _dist+1) {
		x = _testX1;
		y = _testY1;
	} else {
		x = _testX2;
		y = _testY2;
	}
}

if (place_meeting(x,y+vsp,pCollision)) {
	vsp = 0;	
}