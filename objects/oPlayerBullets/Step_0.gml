/// @desc 

enableLive;

colNum = (colNum+1) % 3;
image_blend = cols[colNum];

if (helix) {
	helixRectHeight = Approach(helixRectHeight, 0, 1);
	
	if (!deactive) {
		repeat(6) {
			array_push(helixDots, {
				x: x,
				y: sin((helixDotCounter/4+0.5)*pi/2),
				size: 1
			});
			helixDotCounter++;
			x += 8;
		}
	} else if (array_length(helixDots) == 0) {
		instance_destroy();	
	}
	
	for(var i = 0; i < array_length(helixDots); i++) {
		helixDots[i].size = ApproachFade(helixDots[i].size, 0, 0.08, 0.7);
		if (helixDots[i].size <= 0) {
			array_delete(helixDots,i,1);
			i--;
		}
	}
}