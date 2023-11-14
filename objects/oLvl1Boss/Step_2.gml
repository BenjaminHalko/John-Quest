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
		case 4: {
			if (global.audioTick) {
				var _boundry = oCamera.boundry;
				var _x = _boundry.x + _boundry.sprite_width / 2;
				var _y = _boundry.y + _boundry.sprite_height / 2;
				
				var _angle = random(360);
				var _rot = random_range(3,4.5) * choose(-1,1);
				
				for(var i = 0; i < 3; i++) {
					with(instance_create_layer(_x, _y, layer, oLvl1BossSpiralSnake)) {
						image_angle = _angle + i * 120;
						rotation = _rot;
					}
				}
			}
		} break;
		case 5: {
			
		} break;
	}
} else if (alarm[0] <= 0) {
	movement = ApproachFade(movement, 0, 0.1, 0.7);
	if (--explosionWait > 0 or !global.audioTick or global.audioBeat % 2 != 0) {
		var _x, _y, _depth;
		if (array_length(eyes) > 0) {
			_x = eyes[0].obj.x;
			_y = eyes[0].obj.y;
			_depth = eyes[0].obj.depth;
			eyes[0].obj.flash = 1;
		} else {
			_x = x;
			_y = y;
			_depth = depth;
			flash = 1;
		}
		
		with(instance_create_depth(_x,_y,_depth+1,oTriangleParticle)) {
			image_blend = choose(#ED008C, #8800ED);
			direction = random(360);
			image_angle = random(360);
			speed = random_range(0.5,4);
			radius = 8;
		}
		ScreenShake(2, 2);
	} else {
		var _x, _y, _depth;
		if (array_length(eyes) > 0) {
			_x = eyes[0].obj.x;
			_y = eyes[0].obj.y;
			_depth = eyes[0].obj.depth;
			alarm[0] = 80;
		} else {
			_x = x;
			_y = y;
			_depth = depth;
		}
		
		repeat(50) {
			with(instance_create_depth(_x,_y,_depth+1,oTriangleParticle)) {
				image_blend = c_white;
				direction = random(360);
				image_angle = random(360);
				speed = random_range(0.5,4);
				radius = 12;
			}
		}
		if (array_length(eyes) > 0) {
			instance_destroy(eyes[0].obj);
			array_delete(eyes,0,1);
		}
		ScreenShake(25, 50);
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
	if (phase < 5) {
		explosionWait = 60;
		eyes[0].obj.dead = true;
	} else {
		explosionWait = 120;
		dead = true;
	}
}

// Surface
if (!surface_exists(surf)) surf = surface_create(sprite_width, sprite_height);

// Control Eyes
for (var i = 0; i < array_length(eyes); i++) {
	eyes[i].obj.image_angle = eyes[i].angle + Wave(-3,3,2+eyes[i].waveOffset,eyes[i].waveOffset);
	eyes[i].obj.x = x + eyes[i].x;
	eyes[i].obj.y = ystart + eyes[i].y + Wave(-4,4,5+eyes[i].waveOffset,eyes[i].waveOffset) + sin(((oMusicController.thisBeat % 8)+0.1*abs(eyes[i].y)/50) * pi / 4) * 60 * movement;
}

