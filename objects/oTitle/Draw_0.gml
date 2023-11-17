/// @desc 

for(var i = 0; i < array_length(stars); i++) {
	draw_set_alpha(0.5 - cos(stars[i].alpha * pi) / 2);
	draw_set_color(stars[i].col);
	draw_point(stars[i].x,stars[i].y-600*(1-moveUpPercent)*stars[i].paralax);
}
draw_set_alpha(1);

if (title) {
	draw_sprite(sTitle,0,floor((room_width-180)/2),floor(room_height/3));
	draw_sprite(sTitleBuilding, 0, room_width, room_height);
	draw_sprite(sPlayer,0,350,room_height-buildingHeight+24);
	
	draw_set_font(fRetro);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	// Menu
	var _menuX = 100;
	var _menuY = 160;
	draw_set_color(c_dkgrey);
	draw_text(_menuX,_menuY,"CONTINUE");
	draw_set_color(c_white);
	draw_text(_menuX,_menuY+16,"NEW GAME");
	draw_text(_menuX,_menuY+32,"LEVEL SELECT");
	draw_text(_menuX,_menuY+48,"CREDITS");
	
	draw_sprite(sTitleCursor,0,_menuX-16,_menuY+menuSelected*16);
	
	draw_text(_menuX-16,_menuY+80,"PRESS ENTER");
} else {
	draw_sprite(sTitleLandscape,0,0,room_height+smallerBuildingHeight*moveUpPercent * 1.7);
	
	var _buildingScale = floor(lerp(buildingScale, 1, moveUpPercent) * 144) / 144;
	draw_sprite_ext(sTitleBuilding, 0, room_width, room_height, 1, _buildingScale, 0, c_white, 1);

	draw_sprite(sPlayer,0,350,room_height-_buildingScale*buildingHeight+24);

	var _rectHeight = 48 * (1 - moveUpPercent * 8);
	if (_rectHeight > 0) {
		draw_set_color(c_black);
		draw_rectangle(0,room_height-_rectHeight,room_width,room_height,false);
		
		if (textAlpha > 0 and textNum >= 0) {
			draw_set_alpha(floor(textAlpha * 3) / 3);
			draw_set_color(c_white);
			draw_set_font(fRetro);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text_ext(room_width/2,room_height-_rectHeight/2,text[textNum],16,400);
			draw_set_alpha(1);
		}
	}
}