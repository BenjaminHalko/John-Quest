/// @desc 

enableLive;

var _percent = min(1, (oMusicController.thisBeat - startBeat) / time);

x = lerp(xstart, targetX, _percent);
y = lerp(ystart, targetY, _percent);

for(var i = trailNum; i < floor(point_distance(xstart,ystart,x,y) / 8); i++) {
	with(instance_create_depth(xstart+lengthdir_x(8*i,dir),ystart+lengthdir_y(8*i,dir),depth+1,oLvl1BossHomingTrail)) {
		dir = other.dir;
		waveOffset = (other.trailNum % 4) * 0.25;
	}
	trailNum++;
}

if (_percent == 1) {
	for(var i = 0; i < 10; i++) {
		with(instance_create_layer(x,y,layer,oLvl1BossBullet)) {
			direction = other.dir + (i + 0.5) * 36;
			image_xscale = 0.75;
			image_yscale = 0.75;
		}
	}
	instance_create_layer(x,y,layer,oLvl1BossHomingExplosion);
	instance_destroy();
}

flash = Approach(flash, 0, 0.05);
if (global.audioTick) flash = 1;

if (place_meeting(x,y,oPlayer)) {
	oPlayer.hurtPlayer();
	var _dir = point_direction(x,y,oPlayer.x,oPlayer.y);
	oPlayer.hsp = lengthdir_x(8,_dir);
	oPlayer.vsp = lengthdir_y(8,_dir);
}

image_angle -= 10;