/// @desc 

enableLive;

flash = Approach(flash, 0, 0.3);
bigFlash = ApproachFade(bigFlash, 0, 0.08, 0.7);
image_blend = merge_color(c_white, c_red, flash);