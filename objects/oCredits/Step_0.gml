/// @desc 

enableLive;

for(var i = 0; i < array_length(stars); i++) {
	stars[i].alpha += stars[i].spd;
	if (stars[i].alpha >= 2) {
		stars[i].x = irandom(480);	
		stars[i].y = irandom(270);
		stars[i].spd = random_range(0.001,0.01);
		stars[i].alpha = 0;
	}
}

if (!surface_exists(surf)) surf = surface_create(surfWidth,surfHeight);

// Scroll Credits
scrollPercent = Approach(scrollPercent,1,0.00025);

if (scrollPercent == 1) {
	Input();
	if (keyAction) Transition(rTitle);
}