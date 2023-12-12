/// @desc 

enableLive;

if (draw) {
	image_angle -= 1;

	x = xstart - lengthdir_x(sprite_width/2,image_angle);
	y = ystart - lengthdir_y(sprite_width/2,image_angle) + Wave(-4,4,5,0);

	if (place_meeting(x,y,oPlayer)) {
		draw = false;
		oPlayer.allowMovement = false;
		oPlayer.item = 2;
		destroyCursors();
		ScreenShake(15,30);
		
		repeat(200) {
			with(instance_create_depth(xstart,ystart,depth-1,oTriangleParticle)) {
				speed = random(5);
				spd = 0.02;
				direction = random(360);
				radius = 5;
				image_blend = choose(c_white,#CFE6FE,#AAC7FE,#2F4476);
			}
		}
	}
} else if (oBossLvl4Phase2.dead) {
	if (oPlayer.knockBack == 0) oPlayer.knockBack = 5;
	with(instance_create_depth(oPlayer.x-24-random(16),oPlayer.y+random_range(-16,16),depth-1,oSquareParticle)) {
		direction = 180;
		image_blend = make_color_hsv(random(360),80,128);
		speed = 20;
		spd = 0.09;
		radius = 10;
	}
} else {
	var _len = point_distance(oPlayer.x,oPlayer.y,xstart,ystart);
	var _dir = point_direction(oPlayer.x,oPlayer.y,xstart,ystart);
	if (_len < oPlayer.movespd) {
		oPlayer.hsp = ApproachFade(oPlayerLvl4.hsp,0,0.05,0.7);
		oPlayer.vsp = ApproachFade(oPlayerLvl4.vsp,0,0.05,0.7);
	} else {
		oPlayer.hsp = ApproachFade(oPlayer.hsp,lengthdir_x(oPlayer.movespd,_dir),0.5,0.7);
		oPlayer.vsp = ApproachFade(oPlayer.vsp,lengthdir_y(oPlayer.movespd,_dir),0.5,0.7);
	}
	
	spd = Approach(spd,10,0.6);
	if (spd <= 10 and oPlayer.finalSpin <= 180) {
		oPlayer.finalSpin = ApproachFade(oPlayer.finalSpin,180,spd,0.7);
		if (oPlayer.finalSpin == 180) {
			oBossLvl4Phase2.dead = true;	
		}
	} else {
		oPlayer.finalSpin = (oPlayer.finalSpin+spd) % 360;	
	}
}