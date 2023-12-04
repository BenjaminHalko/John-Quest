/// @desc 

enableLive;

Input()
var _moveX = keyRight - keyLeft;
var _moveY = keyDown - keyUp;
var _fire = mouse_check_button(mb_left);

// Movement
var _dir = point_direction(0,0,_moveX,_moveY);
hsp = ApproachFade(hsp,lengthdir_x(movespd*abs(_moveX),_dir),0.8,0.85);
vsp = ApproachFade(vsp,lengthdir_y(movespd*abs(_moveY),_dir),0.8,0.85);

// Collision
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

// shooting
if (_fire) {
	if (--shotTimer <= 0) {
		with(instance_create_depth(x+random_range(-6,6),y+random_range(-6,6),depth-1,oPlayerBulletsLvl4)) {
			direction = point_direction(x,y,mouse_x,mouse_y);
			image_angle = direction;
		}
		ScreenShake(2,2);
		shotTimer = 5;
	}
} else {
	shotTimer = 0;
}

// animation
propellerIndex = (propellerIndex + propellerSpd) % propellerNum;
