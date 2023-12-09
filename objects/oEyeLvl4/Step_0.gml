/// @desc 

// Inherit the parent event
event_inherited();

if (wandering) {
	if (x != targetX and y != targetY) {
		dir = point_direction(x,y,targetX,targetY);
		var _dist = point_distance(x,y,targetX,targetY);
		spd2 = ApproachFade(spd2,max(0.1,min(_dist/16,2)),0.3,0.7);
		if (_dist < spd2) {
			x = targetX;
			y = targetY;
		} else {
			x += lengthdir_x(spd2, dir);
			y += lengthdir_y(spd2, dir);
		}	
	} else if (--wanderTimer <= 0) {
		var _dir = random(360);
		var _len = random(144);
		targetX = round(xstart+lengthdir_x(_len,_dir));
		targetY = round(ystart+lengthdir_y(_len,_dir));
		wanderTimer = irandom_range(20,40);
		spd2 = 0;
	}
	
	if (point_distance(x,y,oPlayer.x,oPlayer.y) < 128 and point_distance(x,y,xstart,ystart) <= 400) wandering = false;
} else {
	var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
	var _move = (oPlayer.hp > 0);
	if (_move) dir = ApproachCircleEase(dir,_dir,5,0.7);
	spd2 = ApproachFade(spd2,2*_move,0.3,0.7);
	x += lengthdir_x(spd2, dir);
	y += lengthdir_y(spd2, dir);
	
	if (point_distance(x,y,xstart,ystart) > 500) wandering = true;
}