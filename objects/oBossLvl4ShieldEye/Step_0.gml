/// @desc 

enableLive;

// Inherit the parent event
event_inherited();

if (!surface_exists(surf)) surf = surface_create(size,size);

focusPercent = ApproachFade(focusPercent,1,0.05,0.7);

if (--focusTimer <= 0) {
	focusTimer = irandom_range(30,60) - 15 * oBossLvl4Phase1.stunned;
	focusPercent = 0;
	lastFocusX = focusX;
	lastFocusY = focusY;
	
	var _dir = random(360);
	var _len = 16;
	focusX = lengthdir_x(_len,_dir);
	focusY = lengthdir_y(_len,_dir);
	
	if (--focusIsOnPlayer < 0 and (irandom(5) == 0)) or oBossLvl4Phase1.stunned {
		focusIsOnPlayer = irandom_range(1,3);
	}
}

if (focusIsOnPlayer <= 0) {
	var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
	focusX = lengthdir_x(16,_dir);
	focusY = lengthdir_y(16,_dir);
}

image_xscale = Wave(1.1,0.9,0.5,waveOffset);
image_yscale = Wave(0.9,1.1,0.5,waveOffset);