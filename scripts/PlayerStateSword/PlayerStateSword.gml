function PlayerStateSword() {
	//Attack Just Started
	if (animType != PLAYERANIM.SLASH)
	{
		animType = PLAYERANIM.SLASH;
		swordDir = -swordDir;
		var _dir = direction;
		
		var _enemy = instance_nearest(x,y,pEnemy);
		if (_enemy != noone and point_distance(x,y,_enemy.x,_enemy.y) < 48) {
			_dir = point_direction(x,y,_enemy.x,_enemy.y);
		}
		
		instance_create_depth(x+lengthdir_x(1,_dir),y-8+lengthdir_y(1,_dir),depth-lengthdir_y(1,_dir),oSword,{image_angle: _dir, image_yscale: swordDir});
		
	
		//Clear hit list
		if (!ds_exists(hitByAttack,ds_type_list)) hitByAttack = ds_list_create();
		ds_list_clear(hitByAttack);
	}

	PlayerAnimateSprite();

	if(animationEnd)
	{
		state = PlayerStateFree;
		animationEnd = false;
	}
}
