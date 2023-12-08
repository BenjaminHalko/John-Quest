/// @desc

enableLive;

vsp += 0.1;


if (!place_meeting(x,y,oRockNoCollision)) collidable = true;

if (collidable) {
	var _xStart = x;
	var _yStart = y;
	MoveAndCollide(hsp,vsp,-1,-sign(vsp));
	var _testX1 = x;
	var _testY1 = y;
	repeat(3) MoveAndCollide(hsp,vsp,-1,-sign(vsp));
	var _dist = point_distance(x,y,_xStart,_yStart);
	x = _xStart;
	y = _yStart;
	MoveAndCollide(hsp,vsp,1,-sign(vsp));
	var _testX2 = x;
	var _testY2 = y;
	repeat(3) MoveAndCollide(hsp,vsp,1,-sign(vsp));
	if (point_distance(x,y,_xStart,_yStart) < _dist+1) {
		x = _testX1;
		y = _testY1;
	} else {
		x = _testX2;
		y = _testY2;
	}
	
	var _collidedRock = instance_place(x+hsp,y+vsp,oRockLvl4);
	var _me = id;

	var _dir = point_direction(0,0,hsp,vsp);
	if (place_meeting(x+lengthdir_x(1,_dir),y+lengthdir_y(1,_dir),[pCollision,oPlayer])) {
		vsp = 0;
	}
	hsp = Approach(hsp,0,0.005);
	hsp += (x-xprevious)-hsp;
} else {
	x += hsp;
	y += vsp;
}

angle -= (x-xprevious);