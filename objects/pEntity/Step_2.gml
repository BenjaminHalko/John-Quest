/// @desc Entity Loop

depth = -y;

if (lifted) and (instance_exists(oPlayer))
{
	if (oPlayer.animType != PLAYERANIM.LIFT) {
		x = oPlayer.x + oPlayer.topShift;
		y = oPlayer.y;
		z = CARRY_HEIGHT - 16 + 16 * oPlayer.yscale;
		depth = oPlayer.depth-1;
	}
}
	
if (!lifted)
{
	//Be thrown
	if (thrown)
	{
		throwDistanceTravelled = min(throwDistanceTravelled+3,entityThrowDistance);
		x = xstart + lengthdir_x(throwDistanceTravelled, direction);
		y = ystart + lengthdir_y(throwDistanceTravelled, direction);
		if(tilemap_get_at_pixel(global.collisionMap,x,y) > 0)
		{
			thrown = false;
			grav = 0.1;
		}
			
		throwPercent = throwStartPercent + lerp(0, 1 - throwStartPercent, throwDistanceTravelled / entityThrowDistance);
		z = throwPeakHeight * sin(throwPercent * pi);
		if(entityThrowDistance == throwDistanceTravelled)
		{
			thrown = false;
			if (entityThrowBreak) instance_destroy();
		}
	}
	else
	{
		//Fall back to earth
		if (z > 0)
		{
			z = max(z - grav, 0);
			grav += 0.1;
			if(z == 0) and (entityThrowBreak) instance_destroy();
		}
		else
		{
			grav = 0.1;
		}
	}
}

flash = max(flash-0.05,0);