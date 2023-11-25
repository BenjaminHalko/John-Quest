function PlayerStateAutoMove() {
	var _dist = min(speedWalk, point_distance(x,y,autoMoveX,autoMoveY));
	var _dir = point_direction(x,y,autoMoveX,autoMoveY);
	
	//Movement
	hSpeed = lengthdir_x(_dist, _dir);
	vSpeed = lengthdir_y(_dist, _dir);
	
	PlayerCollision();
	
	if (hSpeed != 0 or vSpeed != 0) {
		animType = PLAYERANIM.RUN;
		direction = _dir;
	} else {
		animType = PLAYERANIM.IDLE;
	}
	
	PlayerAnimateSprite();
}