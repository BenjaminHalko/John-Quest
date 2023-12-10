/// @desc 

enableLive;

draw_self();
if (oBossLvl4Phase2.shootEyesPercent != 0) {
	draw_sprite_ext(sprite_index,6,x,y,1,1,0,c_white,oBossLvl4Phase2.shootEyesPercent*0.65);
}