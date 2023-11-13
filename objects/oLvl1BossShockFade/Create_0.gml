/// @desc 

enableLive;

image_alpha = 0;
counter = 4;

image_yscale = irandom_range(7,15);
spikeDir = ((x > oCamera.x) == (image_angle == 180)) * 2 - 1;