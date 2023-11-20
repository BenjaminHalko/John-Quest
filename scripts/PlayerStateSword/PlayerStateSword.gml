function PlayerStateSword() {
	//Attack Just Started
	if (animType != PLAYERANIM.SLASH)
	{
		animType = PLAYERANIM.SLASH;
		direction = round(direction / 90) * 90;
		swordDir = -swordDir;
		instance_create_depth(x+lengthdir_x(1,direction),y-8+lengthdir_y(1,direction),depth-lengthdir_y(1,direction),oSword,{image_angle: direction, image_yscale: swordDir});
		
	
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
