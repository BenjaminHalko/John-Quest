/// @desc 

enableLive;

cols = [c_white, c_lime, c_yellow];
colNum = 0;

speed = 16 * (!helix);

deactive = false;

helixRectHeight = 12;

helixDots = [];
helixDotTimer = 0;
helixDotCounter = 0;

if (helix) {
	with(collision_line(x,y,oCamera.x+oCamera.viewWidthHalf,y,oLvl1Boss,false,false)) {
		bigFlash = 1;
		ScreenShake(12, 20);
	}
}