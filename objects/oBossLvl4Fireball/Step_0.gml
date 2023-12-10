/// @desc 

enableLive;
if (!go) {
	direction = point_direction(x,y,oPlayer.x,oPlayer.y);
	image_angle = 0;
} else {
	speed = ApproachFade(max(2,speed),5,1,0.7);	
}
image_xscale = ApproachFade(image_xscale,1,0.02,0.7);
image_yscale = image_xscale;

var _len = random(40);
var _dir = random(360);
if (isOnScreen()) {
	with(instance_create_depth(x+lengthdir_x(_len,_dir),y+lengthdir_y(_len,_dir),depth-1,oSquareParticle)) {
		image_blend = merge_color(#EE371B,#EEA01B,random(1));
		if (!other.go) {
			direction = random(360);
			speed = 1;
		} else {
			direction = other.direction+180+random_range(-5,5);
			speed = random_range(0.1,1); 
		}
	
		spd = 0.05;
	}
}

var _rock = instance_place(x,y,oBigRock);
if (_rock != noone and isOnScreen()) {
	repeat(50) {
		_len = random(40);
		_dir = random(360);
		with(instance_create_depth(x+lengthdir_x(_len,_dir),y+lengthdir_y(_len,_dir),depth-1,oSquareParticle)) {
			image_blend = merge_color(#EE371B,#EEA01B,random(1));
			direction = random(360);
			speed = random(3);
			spd = 0.05;
		}
	}
	repeat(200) {
		_len = random(128);
		_dir = random(360);
		with(instance_create_depth(_rock.x+lengthdir_x(_len,_dir),_rock.y+lengthdir_y(_len,_dir),depth-1,oSquareParticle)) {
			image_blend = #060606;
			direction = random(360);
			speed = random(5);
			spd = 0.05;
			radius = 10;
		}
	}
	audio_play_sound(snBreak,1,false);
	
	instance_destroy(_rock);
	instance_destroy();
}