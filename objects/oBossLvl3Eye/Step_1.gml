/// @desc 

if (dead) {
	if (type == INVENTORY.BOMB) {
		if (count > 16) {
			image_angle -= dir * 40;
			
			image_xscale = random_range(0.8,1.5);
			image_yscale = random_range(0.8,1.5);
			y += grav;
			grav += 0.7;
			x -= 4 * dir;
			oInventory.stopReturn = false;
			
			if (y > 600) {
				oBossLvl3.showingAnimation = false;
				instance_destroy();
			}
		} else {
			oInventory.stopReturn = true;
			oInventory.itemReturnPercent = 0;
			oInventory.itemX = bombX;
			oInventory.itemY = bombY - (timer - 1) * 32;
			if (--timer <= 0) {
				repeat(50) {
					with(instance_create_depth(bombX,bombY,depth-1,oSquareParticle)) {
						image_blend = choose(merge_color(c_gray,c_ltgrey,random(1)),merge_color(c_red,c_yellow,random(0.7)));
						direction = random(360);
						image_angle = random(360);
						speed = random_range(0.3,9);
						radius = 10;
						spd = 0.08;
					}
				}
		
				ScreenShake(6,3);
		
				timer = 5;
				count++;
				bombX = random_range(bbox_left,bbox_right);
				bombY = random_range(bbox_top,bbox_bottom);
		
				if (count > 16) {
					repeat(500) {
						with(instance_create_depth(x,y,depth-1,oSquareParticle)) {
							image_blend = choose(c_dkgray,c_grey,c_ltgray);
							direction = random(360);
							image_angle = random(360);
							speed = random_range(0.2,10);
							radius = 10;
							spd = 0.02;
						}
					}
					
					grav = -16;
					dir = choose(-1,1);
					audio_play_sound(snExplosion,1,false);
				} else {
					audio_play_sound(snExplosionShort,1,false);
				}
			}
			image_xscale = random_range(0.8,1.5);
			image_yscale = random_range(0.8,1.5);
			image_angle = random_range(-5,5);
			x = random_range(xstart-5,xstart+5);
			y = random_range(ystart-5,ystart+5);
		}
	} else if (type == INVENTORY.SWORD) {
		if (count > 16) {
			image_angle -= dir * 40;
			
			image_xscale = random_range(0.8,1.5);
			image_yscale = random_range(0.8,1.5);
			y += grav;
			grav += 0.4;
			x -= 4 * dir;
			oInventory.stopReturn = false;
			
			if (y > 600) {
				oBossLvl3.showingAnimation = false;
				instance_destroy();
			}
		} else {
			oInventory.stopReturn = true;
			oInventory.itemReturnPercent = 0;
			if (percent == 1 and --timer <= 0) {
				swordX1 = swordX2;
				swordY1 = swordY2;
				var _dir = point_direction(swordX1,swordY1,x,y)+random_range(-90,90);
				swordX2 = x + lengthdir_x(sprite_width*0.7,_dir) + 25;
				swordY2 = y + lengthdir_y(sprite_height,_dir) + 25;
				percent = 0;
				timer = 2;
				audio_play_sound(snSwordSwing,1,false);
				count++;
				if (count > 16) {
					repeat(500) {
						with(instance_create_depth(x,y,depth-1,oTriangleParticle)) {
							image_blend = c_white;
							direction = random(360);
							image_angle = random(360);
							speed = random_range(0.2,12);
							radius = 10;
							spd = 0.02;
						}
					}
					grav = -8;
					dir = choose(-1,1);
					audio_play_sound(snExplosion,1,false);
				} else {
					audio_play_sound(snSwordSwing,1,false);
				}
			}
		
			percent = Approach(percent,1,0.3);
			var _lastX = oInventory.itemX;
			var _lastY = oInventory.itemY;
			oInventory.itemX = lerp(swordX1,swordX2,percent);
			oInventory.itemY = lerp(swordY1,swordY2,percent);
			var _dir = point_direction(swordX1,swordY1,swordX2,swordY2)
			repeat(50) {
				var _dist = random(point_distance(_lastX,_lastY,oInventory.itemX,oInventory.itemY));
				with(instance_create_depth(oInventory.itemX+random_range(-1,1)-25+lengthdir_x(_dist,_dir),oInventory.itemY+lengthdir_y(_dist,_dir)+random_range(-1,1)-25,depth-1,oTriangleParticle)) {
					image_blend = merge_color(c_white,c_gray,random(1));
					direction = point_direction(other.swordX2,other.swordY2,other.swordX1,other.swordY1) + random_range(-10,10);
					image_angle = random(360);
					speed = 0;
					radius = 3;
					spd = 0.03;
				}
			}
			CreateAfterImageSprite(sInventoryItems,INVENTORY.SWORD,oInventory.itemX,oInventory.itemY);
		
			image_xscale = random_range(0.8,1.5);
			image_yscale = random_range(0.8,1.5);
			image_angle = random_range(-5,5);
			x = random_range(xstart-5,xstart+5);
			y = random_range(ystart-5,ystart+5);
		}
	} else {
		if (!playedSound) {
			audio_stop_sound(mLvl3MusicBoss);
			audio_play_sound(snShopkeeperLeave,1,false,1,0.14);
			playedSound = true;
			oInventory.inventory[1] = -1;
			oInventory.itemReturn = -1;
			oInventory.itemReturnPercent = 1;
		}
		
		var _destroy = true;
		with(oBossLvl3Eye) {
			dead = true;
			playedSound = true;	
			y -= upSpd;
			if (y > -100) _destroy = false;
		}
		
		if (_destroy) {
			oBossLvl3.showingAnimation = false;
			audio_stop_sound(oInventory.talking);
			oInventory.talking = audio_play_sound(snDefeatShopkeepers,1,false);
			oInventory.subtitles = "Well that was easy...";
            
            if (STEAM_ENABLED) {
                call_later(audio_sound_length(snDefeatShopkeepers), time_source_units_seconds, function() {
                    steam_set_achievement("world3_bribery");
                });
            }
			instance_destroy(oBossLvl3Eye);
		}
	}
} else {
	x = Wave(xstart-200,xstart+200,5.2+waveOffset,waveOffset);	
	y = Wave(ystart-50,ystart+50,2.3+waveOffset,1-waveOffset);
	image_xscale = Wave(0.8,1.2,0.2+waveOffset/4,waveOffset)*scale;
	image_yscale = Wave(0.8,1.2,0.2+waveOffset/4,1-waveOffset)*scale;
	scale = ApproachFade(scale,1,0.1,0.6);
}