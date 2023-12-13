/// @desc 

for(var i = 0; i < array_length(stars); i++) {
	draw_set_alpha(0.5 - cos(stars[i].alpha * pi) / 2);
	draw_set_color(stars[i].col);
	draw_point(stars[i].x,stars[i].y-600*(1-moveUpPercent)*stars[i].paralax);
}
draw_set_alpha(1);

if (title) {
	draw_sprite(sTitle,0,floor((room_width-180)/2),24);
	draw_sprite(sTitleBuilding, 1, room_width, room_height);
	draw_sprite(sPlayerLvl1,0,350,room_height-buildingHeight+24);
	
	draw_set_font(fRetro);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	// Menu
	var _menuX = 100;
	var _menuY = 160;
	draw_set_color(c_white);
	if (menu != MENU.CREDITS) draw_text(_menuX-16,_menuY+80,"PRESS ENTER");
	if (menu == MENU.MAIN) {
		for(var i = 0; i < 4; i++) {
			draw_set_color(i != 0 or lastLevel != -1 ? c_white : c_dkgray);
			if (allowInput or menuSelected != i or blink % 2) draw_text(_menuX,_menuY+16*i,mainMenu[i]);
		}
		draw_sprite(sTitleCursor,0,_menuX-16+blinkWave,_menuY+menuSelected*16);
	} else if (menu == MENU.LEVELSELECT) {
		for(var i = 0; i < 7; i++) {
			if (allowInput or menuSelected != i or blink % 2) draw_text(_menuX+(max(0,i-1) % 2)*80,_menuY+(floor(max(0,i+1) / 2))*16,levelSelect[i]);
		}
		draw_sprite(sTitleCursor,0,_menuX-16+blinkWave+(max(0,menuSelected-1) % 2)*80,_menuY+(floor(max(0,menuSelected+1) / 2))*16);
		
		draw_set_color(c_dkgray);
		draw_text(_menuX+48,_menuY-8,"GAME ISNT SAVED\nIN LEVEL SELECT");
	} else if (menu == MENU.NEWGAME) {
		draw_text(_menuX-16,_menuY,"ARE YOU SURE YOU\nWANT TO START OVER?");
		for(var i = 0; i < 2; i++) {
			if (allowInput or menuSelected != i or blink % 2) draw_text(_menuX,_menuY+32+16*i,newGame[i]);
		}
		draw_sprite(sTitleCursor,0,_menuX-16+blinkWave,_menuY+32+16*menuSelected);
	} else {
		draw_set_font(fRPG);
		draw_text(_menuX-32,_menuY-10,"Programming - Benjamin\nLevel Design - Benjamin\nMusic & Sound FX - Benjamin\nCharacter Art - Morlan\nKey-Item Art\n  - Morlan / Haoxi / Benjamin\nEnvironmental Art\n  - Morlan / Haoxi / Benjamin");
		
		draw_set_color(c_dkgray);
		draw_text(_menuX-32,_menuY-28,"Thanks to everyone that made this possible");
	}
} else {
	draw_sprite(sTitleLandscape,0,0,room_height-48+smallerBuildingHeight*moveUpPercent * 1.7);
	
	var _buildingScale = floor(lerp(buildingScale, 1, moveUpPercent) * 144) / 144;
	draw_sprite_ext(sTitleBuilding, 0, room_width, room_height, 1, _buildingScale, 0, c_white, 1);
	if (blend != 0) draw_sprite_ext(sTitleBuilding, 1, room_width, room_height, 1, _buildingScale, 0, c_white, blend);

	draw_sprite(sPlayerLvl1,0,350,room_height-_buildingScale*buildingHeight+24);

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