/// @desc 

image_angle = random(360);
bigFlash = 0;

flash = 0;
flashTimer = 0;

image_xscale = 0;
image_yscale = 0;

targetX = random_range(oCamera.x-oCamera.viewWidthHalf,oCamera.x+oCamera.viewWidthHalf);
targetY = random_range(oCamera.y-oCamera.viewHeightHalf,oCamera.y+oCamera.viewHeightHalf);

targetPercent = 0;

beatCount = 4;