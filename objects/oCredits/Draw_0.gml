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
var _y = round(lerp(startY,endY,scrollPercent));

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
        draw_set_font(global.fontRetro);
        if (i >= array_length(credits) - 2) _y += finalCreditsOffset;
        if (is_numeric(_text[0])) {
            draw_text_ext(_x,_y + global.fontRetroYOffset,$"~ {worldText}   ~",10,500);
            draw_sprite(sWorld,_text[0],_x-string_width($"~ {worldText} 0 ~")/2+string_width($"~ {worldText} "),_y);
        } else {
            draw_text_ext(_x,_y + global.fontRetroYOffset,string_upper(_text[0]),10,500);
        }
		_y += headerOffsetAfter;
	} else {
        if (struct_exists(languageFonts, _text[0])) {
            var _font = languageFonts[$ _text[0]];
            draw_set_font(_font.fontRPG);
            draw_text_ext(_x,_y + _font.fontRetroYOffset,_text[0],10,500);
        } else {
            draw_set_font(global.fontRPG);
            draw_text_ext(_x,_y + global.fontRetroYOffset,_text[0],10,500);
        }
		
		draw_set_font(global.fontRetro);
		_y += nameOffset + (string_count("\n",credits[i][0])*10);
		draw_text(_x,_y + global.fontRetroYOffset,string_upper(_text[1]));
	}
	
	if (i == 0) _y += firstOffset;
}

surface_reset_target();
draw_surface(surf,0,room_height-surfHeight);