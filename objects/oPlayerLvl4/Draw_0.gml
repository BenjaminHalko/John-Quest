/// @desc 

enableLive;

var _y = Wave(-2,2,2,0);
var _spriteAngle = (x - xprevious) * -10;
var _yscale = 1 + (y - yprevious) * -0.02;

draw_sprite_ext(sprite_index,image_index,x,y+_y,image_xscale,_yscale,_spriteAngle,image_blend,image_alpha);
draw_sprite_ext(sPlayerPropeller,propellerIndex,x+lengthdir_x(12,90+_spriteAngle),y+lengthdir_y(12,90+_spriteAngle)+_y,1,1/(1-vsp/movespd*0.6),_spriteAngle,c_white,1);