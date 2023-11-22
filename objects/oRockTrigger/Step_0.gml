/// @desc 

if (place_meeting(x,y,oPlayer)) {
	activated = true;
}

if (activated and (!place_meeting(x,y,oPlayer) or noWait)) {
	var _playerPos = (checkX) ? oPlayer.x : oPlayer.y-8;
	var _pos = (checkX) ? x : y+8;
	if ((_playerPos > _pos) == greater) or noWait {
			for(var i = 0; i < array_length(rocks); i++) {
				instance_activate_object(rocks[i]);
				with(rocks[i]) {
					z = 120 + (i * 70)
					grav = 10;
				}
			}
			instance_destroy();
	} else {
		activated = false;	
	}
}