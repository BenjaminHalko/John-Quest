function PlayerStateDead()
{
	hSpeed = 0;
	vSpeed = 0;
	
	//if just arriving in this state
	if(animType != PLAYERANIM.DIE)
	{
		animType = PLAYERANIM.DIE;
	}
	
	PlayerAnimateSprite();
	
	//Animation ending this frame?
	if(animationEnd) {
		Transition(rLvl2, 1);
	}
}