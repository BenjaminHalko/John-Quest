/// @desc 

enableLive;

draw_sprite(sprite_index,image_index,round(x),round(y));
if (oBossLvl4Phase2.shootEyesPercent != 0) {
	draw_sprite_ext(sprite_index,6,round(x),round(y),1,1,0,c_white,oBossLvl4Phase2.shootEyesPercent*0.65);
}