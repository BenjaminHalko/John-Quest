/// @desc 

draw_self();
var _spikeDir = spikeDir * 90 + image_angle - 90;
var _spikeX = x + lengthdir_x(28, _spikeDir) - lengthdir_y(8 * spikeDir, _spikeDir);
var _spikeY = y + lengthdir_y(28, _spikeDir) - lengthdir_x(8 * spikeDir, _spikeDir);

draw_sprite_ext(sSpike, 0, _spikeX, _spikeY, image_yscale-1, -spikeDir, image_angle+90, c_white, image_alpha);