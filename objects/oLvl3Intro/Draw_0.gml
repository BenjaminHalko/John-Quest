/// @desc 

var _scale = (0.5 - max(percent-0.5,0))*2;
draw_sprite_ext(sPlayerLvl1,0,128,224-300*(1-percent),_scale,_scale,rotation,c_white,1);