function PlayerThrow() {
	with (global.iLifted)
	{
		lifted = false;
		persistent = false;
		thrown = true;
		z = CARRY_HEIGHT;
		throwPeakHeight = z + 10;
		throwDistanceTravelled = 0;
		throwStartPercent = (CARRY_HEIGHT/throwPeakHeight) * 0.5;
		throwPercent = throwStartPercent;
		xstart = x;
		ystart = y;
		
		direction = other.direction;
		var _enemy = instance_nearest(x,y,pEnemy);
		if (_enemy != noone and point_distance(x,y,_enemy.x,_enemy.y) < 48) {
			direction = point_direction(x,y,_enemy.x,_enemy.y);
			entityThrowDistance = point_distance(x,y,_enemy.x,_enemy.y)-8;
		}
	}
	
	PlayerDropItem();
}