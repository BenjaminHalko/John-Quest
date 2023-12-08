/// @desc

enableLive;

vsp += 0.1;

if (!place_meeting(x,y,oRockNoCollision)) collidable = true;

if (collidable) {
	MoveAndCollide(hsp,vsp,0,-sign(vsp),true);
	var _collidedRock = instance_place(x+hsp,y+vsp,oRockLvl4);
	var _me = id;

	while (_collidedRock != noone) {
		if (_collidedRock.y < _me.y) {
			_collidedRock = noone;
			_me.y += vsp;
		} else {
			_me = _collidedRock;
			with(_me) {
				_collidedRock = instance_place(x+hsp,y+vsp,oRockLvl4);	
			}
		}
	}

	var _dir = point_direction(0,0,hsp,vsp);
	if (place_meeting(x+lengthdir_x(1,_dir),y+lengthdir_y(1,_dir),[pCollision,oPlayer])) {
		if (hsp == 0) {
			if (!position_meeting(bbox_left-3,bbox_bottom,pCollision)) {
				hsp = -max(1,vsp*0.75);
			} else {
				if (!position_meeting(bbox_right+3,bbox_bottom,pCollision)) {
					hsp = max(1,vsp*0.75);
				}	
			}
		} else {
			hsp = Approach(hsp,(x-xprevious)/2,5);	
		}
	
		vsp = 0;
	}
} else {
	x += hsp;
	y += vsp;
}

angle -= (x-xprevious);