if (global.audioTick) {
	timer--;
	
	if (global.audioBeat % beatLoop == beatOffset) {
		timer = length;
	}
}

if (percent != clamp(timer,0,1)) {
	percent = Approach(percent, clamp(timer,0,1), 0.2);
	var _onScreen = isOnScreen();
	
	if (_onScreen and percent == clamp(timer,0,1)) {
		ScreenShake(5, 5);	
	}
	
	// After images
	if (_onScreen and !instance_exists(oIntroLvl1)) {
		for(var i = 0; i < array_length(attachedObjects); i++) {
			CreateAfterImage(attachedObjects[i]);	
		}
		CreateAfterImage(id);
	}
}

x = lerp(xstart+xDist, xstart, percent);
y = lerp(ystart+yDist, ystart, percent);

for(var i = 0; i < array_length(attachedObjects); i++) {
	with(attachedObjects[i]) {
		x = lerp(xstart+other.xDist, xstart, other.percent);
		y = lerp(ystart+other.yDist, ystart, other.percent);
	}
}