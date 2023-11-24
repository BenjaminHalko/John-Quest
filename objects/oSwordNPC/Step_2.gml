/// @desc 

enableLive;

// Inherit the parent event
event_inherited();

z = Wave(2,8,2,0);

if (point_distance(x,y,oPlayer.x,oPlayer.y) > 48) {
	if ((x == xTo) and (y == yTo)) or (timePassed > wanderDistance/moveSpd)
	{
		hSpeed = 0;
		vSpeed = 0;
	
		//Set new target destination
		if (++wait >= waitDuration or timePassed < 5)
		{
			if (++count >= 12) or (currentPlace == 0 and point_distance(x,y,xstart,ystart) < 120) {
				if (currentPlace == 0) {
					currentPlace = random_range(1,array_length(places)-1);	
				} else {
					currentPlace = 0;	
				}
				xstart = places[currentPlace][0];
				ystart = places[currentPlace][1];
			}
			wait = 0;
			timePassed = 0;
			var _extra = 96 * (currentPlace == 0);
			dir = point_direction(x,y,xstart,ystart) + irandom_range(-100,100);
			wanderDistance = 256+_extra;
			for(var i = 0; i < 500; i++) {
				if (!collision_line(x,y,x+lengthdir_x(wanderDistance,dir),y+lengthdir_y(wanderDistance,dir),[global.collisionMap,oPlant,oRoof],false,false)) {
					break;	
				}
				
				wanderDistance--;
				if (wanderDistance <= 104+_extra) {
					dir = point_direction(x,y,xstart,ystart) + irandom_range(-150,150);
					wanderDistance = 256+_extra;
				}
			}
			
			
			wanderDistance = random_range(96+_extra,wanderDistance-8);
			xTo = x + lengthdir_x(wanderDistance, dir);
			yTo = y + lengthdir_y(wanderDistance, dir);
		}
	}
	else //Move toward new destination
	{
		timePassed++;
		var _distanceToGo = point_distance(x,y,xTo,yTo);
		var _speedThisFrame = moveSpd;
		if (_distanceToGo < moveSpd) _speedThisFrame = _distanceToGo;
		dir = point_direction(x,y,xTo,yTo);
		hSpeed = lengthdir_x(_speedThisFrame,dir);
		vSpeed = lengthdir_y(_speedThisFrame,dir);
		if(hSpeed != 0) image_xscale = sign(hSpeed);
	
		//Collide && move
		EnemyTileCollision();
	}
} else {
	image_xscale = 1-(oPlayer.x < x) * 2;
	xTo = x;
	yTo = y;
	
}