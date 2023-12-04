/// @desc 

enableLive;

draw_self();
draw_sprite_ext(sPlayerPropeller,propellerIndex,x+lengthdir_x(12,90+image_angle),y+lengthdir_y(12,90+image_angle),1,1/(1-vsp/movespd*0.6),image_angle,c_white,1);