function PlayerStateBonk() {
	//Movement
	hSpeed = lengthdir_x(speedBonk, direction-180);
	vSpeed = lengthdir_y(speedBonk, direction-180);

	moveDistanceRemaining = max(0, moveDistanceRemaining - speedBonk);
	var _collided = PlayerCollision();

	//Update Sprite
	animType = PLAYERANIM.HURT;

	//Change Height
	z = sin(((moveDistanceRemaining / distanceBonk) * pi)) * distanceBonkHeight;
	
	// Animate
	PlayerAnimateSprite();


	//Change State
	if(moveDistanceRemaining <= 0)
	{
		if (global.playerHealth <= 0) state = PlayerStateDead;
		else state = PlayerStateFree;
	}


}
