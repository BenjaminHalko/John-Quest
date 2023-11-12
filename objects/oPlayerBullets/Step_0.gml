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
	
	if (!attacked and helixRectHeight > 0) {
		if (collision_line(x,y,oCamera.x+oCamera.viewWidthHalf,y,[oLvl1Boss,oLvl1BossSmall],false,false) != noone) {
			with(oLvl1Boss) {
				bigFlash = 1;
				ScreenShake(12, 20);
				hp -= 20;
				other.attacked = true;
			}
		}
	}
}

if (!helix) {
	var _boss = collision_rectangle(bbox_left,bbox_top,bbox_left+speed,bbox_bottom,[oLvl1BossSmall, oLvl1Boss],false,false);
	if (_boss != noone) {
		_boss.flash = 1;
		oLvl1Boss.hp--;
		ScreenShake(2, 2);
		instance_destroy();
	}
}