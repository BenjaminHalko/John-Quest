/// @desc 

draw_set_alpha(percent);
draw_set_color(createdTriangles ? c_black : c_white);
draw_rectangle(0,0,room_width+128,room_height,false);
if (createdTriangles) draw_sprite(sPlayerLvl1,0,oCamera.x+110,oCamera.y+15);
draw_set_alpha(1);