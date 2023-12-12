/// @desc 

draw_set_alpha(percent);
draw_set_color(createdTriangles ? c_black : c_white);
draw_rectangle(0,0,room_width,room_height,false);
draw_sprite(sPlayerLvl1,0,lerp(oPlayer.x,oCamera.x+110,playerMovePercent),lerp(oPlayer.y+Wave(-2,2,2,0)*oPlayer.wavePercent,oCamera.y-15,playerMovePercent));
draw_set_alpha(1);