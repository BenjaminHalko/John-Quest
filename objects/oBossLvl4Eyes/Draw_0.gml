/// @desc 

enableLive;

draw_sprite(sprite_index,image_index,round(x),round(y));

if (oBossLvl4Phase2.shootEyesPercent != 0) {
	draw_sprite_ext(sprite_index,6,round(x),round(y),1,1,0,c_white,oBossLvl4Phase2.shootEyesPercent*0.65);	
}

if (oBossLvl4Phase2.deadPercent != 0) {
	draw_sprite_ext(sprite_index,7,round(x),round(y),1,1,0,choose(c_white,make_color_hsv(random(360),50,255)),oBossLvl4Phase2.deadPercent);	
}