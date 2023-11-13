/// @desc 

enableLive;

var _spikeDir = spikeDir * 90 + image_angle - 90;
var _spikeX = lengthdir_x(28, _spikeDir) - lengthdir_y(8 * spikeDir, _spikeDir);
var _spikeY = lengthdir_y(28, _spikeDir) - lengthdir_x(8 * spikeDir, _spikeDir);

if (oLvl1Boss.inBetweenPhases) {
	image_yscale = ApproachFade(image_yscale,0,1,0.6);
	with(spikes) {
		var _len = (other.image_yscale - other.targetYscale) * 16;
		x = other.x + _spikeX + lengthdir_x(_len, image_angle);
		y = other.y + _spikeY + lengthdir_y(_len, image_angle);	
	}
	if (image_yscale <= 0) {
		instance_destroy(spikes);
		instance_destroy();
	}
} else if (image_yscale != targetYscale) {
	image_yscale = ApproachFade(image_yscale, targetYscale, 4, 0.6);
	
	if (image_yscale >= targetYscale-0.01 and global.audioTick) {
		spikes = instance_create_layer(x+_spikeX,y+_spikeY,layer,oSpike);
		spikes.image_xscale = image_yscale-1;
		spikes.image_yscale = -spikeDir;
		spikes.image_angle = image_angle+90;
		spikes.flash = 1;
		flash = 1;
		image_yscale = targetYscale;
		instance_destroy(fade);
	}
} else {
	flash = Approach(flash, 0, 0.05);
	moveSpd = Approach(moveSpd, 6, 0.5);
	x += lengthdir_x(moveSpd, image_angle + 90 * spikeDir - 90);
	y += lengthdir_y(moveSpd, image_angle + 90 * spikeDir - 90);
	spikes.x = x+_spikeX;
	spikes.y = y+_spikeY;
	
	if (point_distance(x,y,oCamera.x,oCamera.y) > 480) {
		instance_destroy(spikes);
		instance_destroy();
	}
}