/// @desc 

if (lvl4) {
	var _scale = min(1,percent*2);
	draw_sprite_ext(sPlayerLvl4,0,128,224-300*percent,_scale,_scale,0,c_white,1);
	draw_sprite_ext(sPlayerPropeller,index,128,224-300*percent-12*_scale,_scale,_scale,0,c_white,1);
} else {
	var _scale = (0.5 - max(percent-0.5,0))*2;
	draw_sprite_ext(sPlayerLvl1,0,128,224-300*(1-percent),_scale,_scale,index,c_white,1);
}