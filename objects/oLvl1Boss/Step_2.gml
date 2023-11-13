/// @desc 

enableLive;

// Bullets
if (!inBetweenPhases) {
	movement = ApproachFade(movement, 1, 0.1, 0.7);
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
		case 2: {
			if (global.audioTick and global.audioBeat % 2 == 0) {
				var _choice = irandom(1);
				if (_choice) {
					instance_create_layer(irandom_range(-240,240)+oCamera.x,oCamera.y-32-oCamera.viewHeightHalf,layer,oLvl1BossShockFade,{image_angle: 180});
				} else {
					instance_create_layer(irandom_range(-240,240)+oCamera.x,oCamera.y+32+oCamera.viewHeightHalf,layer,oLvl1BossShockFade);
				}
			}
		} break;
		case 3: {
			if (global.audioTick) {
				if (irandom(2) == 0) {
					var _y = irandom_range(-135,135)+oCamera.y;
					if (irandom(3) == 0) _y = oPlayer.y + irandom_range(-6,6);
					with(instance_create_layer(oCamera.x, _y, layer, oLvl1BossCrusherFade)) {
						image_angle += 90;
						image_yscale = 34;
					}
				} else {
					var _x = irandom_range(-240,240)+oCamera.x;
					if (irandom(3) == 0) _x = oPlayer.x + irandom_range(-6,6);
					instance_create_layer(_x, oCamera.y, layer, oLvl1BossCrusherFade);
				}
			}
		} break;
	}
} else if (alarm[0] <= 0) {
	movement = ApproachFade(movement, 0, 0.1, 0.7);
	if (--explosionWait > 0 or !global.audioTick or global.audioBeat % 2 != 0) {
		eyes[0].obj.flash = 1;
		with(instance_create_depth(eyes[0].obj.x,eyes[0].obj.y,eyes[0].obj.depth+1,oTriangleParticle)) {
			image_blend = choose(#ED008C, #8800ED);
			direction = random(360);
			image_angle = random(360);
			speed = random_range(0.5,4);
			radius = 8;
		}
		ScreenShake(2, 2);
	} else {
		alarm[0] = 80;
		repeat(50) {
			with(instance_create_depth(eyes[0].obj.x,eyes[0].obj.y,eyes[0].obj.depth+1,oTriangleParticle)) {
				image_blend = c_white;
				direction = random(360);
				image_angle = random(360);
				speed = random_range(0.5,4);
				radius = 12;
			}
		}
		instance_destroy(eyes[0].obj);
		array_delete(eyes,0,1);
		ScreenShake(30, 50);
	}
}

stunned = ApproachFade(stunned, (inBetweenPhases and alarm[0] <= 0), 0.1, 0.7);

// Boss Flashing
flash = Approach(flash, 0, 0.1);
bigFlash = ApproachFade(bigFlash, 0, 0.03, 0.7);
image_blend = merge_color(c_white, c_red, flash);

x = ApproachFade(x,xstart-96,5,0.7);

y = ystart + Wave(-4,4,5,0) + sin((oMusicController.thisBeat % 8) * pi / 4) * 60 * movement;

x += random_range(-5, 5) * min(4, flash + bigFlash * 4);
y += random_range(-5, 5) * min(4, flash + bigFlash * 4);

// Lock HP
hp = max(hp, maxHp / 6 * (5-phase));

if (global.audioTick and global.audioBeat % 4 == 0 and hp == maxHp / 6 * (5-phase) and !inBetweenPhases) {
	inBetweenPhases = true;
	explosionWait = 60;
	eyes[0].obj.dead = true;
}

// Surface
if (!surface_exists(surf)) surf = surface_create(sprite_width, sprite_height);

// Control Eyes
for (var i = 0; i < array_length(eyes); i++) {
	eyes[i].obj.image_angle = eyes[i].angle + Wave(-3,3,2+eyes[i].waveOffset,eyes[i].waveOffset);
	eyes[i].obj.x = x + eyes[i].x;
	eyes[i].obj.y = ystart + eyes[i].y + Wave(-4,4,5+eyes[i].waveOffset,eyes[i].waveOffset) + sin(((oMusicController.thisBeat % 8)+0.1*abs(eyes[i].y)/50) * pi / 4) * 60 * movement;
}

