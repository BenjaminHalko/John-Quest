/// @desc 

// Draw Stars
for(var i = 0; i < array_length(stars); i++) {
	draw_set_alpha(0.5 - cos(stars[i].alpha * pi) / 2);
	draw_set_color(stars[i].col);
	draw_point(stars[i].x,stars[i].y);
}
draw_set_alpha(1);

// Draw Building
draw_sprite(sTitleBuilding,1,room_width,room_height);

var _x = surfWidth / 2;
var _y = lerp(startY,endY,scrollPercent);

// Draw Title
draw_sprite(sTitle,0,_x,max(_y,24));

// Draw Text
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
_y += titleOffset;
_y -= room_height - surfHeight;
surface_set_target(surf);
draw_clear_alpha(c_black, 0);

for(var i = 0; i < array_length(credits); i++) {
	_y += credits[i][1];
	var _text = credits[i][0];
	if (array_length(_text) == 1) {
		if (_text[0] == "_gamemaker_") {
			_y += logoOffsetBefore;
			draw_sprite(sGameMaker,0,_x,_y);
		} else {
			draw_set_font(fRetro);
			if (string_starts_with(_text[0],"~ World")) {
				var _index = real(string_split(_text," ")[3]);
				draw_text_ext(_x,_y,string_upper("~ World   ~"),10,500);
				draw_sprite(sWorld,_index,_x-string_width(_text[0])/2+string_width("~ WORLD "),_y);
			} else {
				draw_text_ext(_x,_y,string_upper(_text[0]),10,500);
			}
		}
		if (i >= array_length(credits) - 3) _y += finalCreditsOffset;
		_y += headerOffsetAfter;
	} else {
		draw_set_font(fRPG);
		draw_text_ext(_x,_y,_text[0],10,500);
		
		draw_set_font(fRetro);
		_y += nameOffset + (string_count("\n",credits[i][0])*10);
		draw_text(_x,_y,string_upper(_text[1]));
	}
	
	if (i == 0) _y += firstOffset;
}

surface_reset_target();
draw_surface(surf,0,room_height-surfHeight);