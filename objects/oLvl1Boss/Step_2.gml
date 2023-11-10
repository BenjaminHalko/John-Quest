/// @desc 

enableLive;

// Bullets
if (!inBetweenPhases) {
	switch(phase) {
		case 0: default: {
			if (global.audioTick and global.audioBeat % 2 == 0) {
				instance_create_layer(x,y,layer,oLvl1BossBomb)
			}
		} break;
		case 1: {
			if (global.audioTick and global.audioBeat % 2 == 0) {
				instance_create_layer(floor(oCamera.x+oCamera.viewWidthHalf+20),oPlayer.y+irandom_range(-64,64)*(global.audioBeat % 4 == 2),layer,oLvl1BossSnake);
			}
		
			if (global.audioTick) {
				var _camBoundryX = oCamera.boundry.x;
				var _camBoundryY = oCamera.boundry.y;
				while(1) {
					var _size = 3 * 16;
					var _x = _camBoundryX + irandom(480/_size) * _size
					var _y = _camBoundryY + irandom(270/_size) * _size;
				
					if (!collision_rectangle(_x,_y,_x+_size,_y+_size,oLvl1BossBlock,false,false)) {
						with(instance_create_layer(_x+8,_y+8,layer,oLvl1BossBlock)) {
							scale = _size/16;
						}
						break;
					}
				}
			}
		} break;
	}
}

// Boss Flashing
flash = Approach(flash, 0, 0.3);
bigFlash = ApproachFade(bigFlash, 0, 0.05, 0.7);
image_blend = merge_color(c_white, c_red, flash);

x = ApproachFade(x,xstart-96,5,0.7);

y = ystart + sin((oMusicController.thisBeat % 4) * pi / 2) * 60;

x += random_range(-5, 5) * min(4, flash + bigFlash * 4);
y += random_range(-5, 5) * min(4, flash + bigFlash * 4);

// Lock HP
//hp = max(hp, maxHp / 6 * (5-phase));

if (global.audioTick and global.audioBeat % 4 == 0 and hp == maxHp / 6 * (5-phase)) {
	phase++;
	inBetweenPhases = true;
}

// Surface
if (!surface_exists(surf)) {
	surf = surface_create(sprite_width, sprite_height);
}