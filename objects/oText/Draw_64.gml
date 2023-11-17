/// @desc Draw Textbox

enableLive;

draw_sprite_ext(sTextboxBg, 0, x1, y1, (x2 - x1) / 24, (y2 - y1) / 24, 0, c_white, 1);
draw_set_font(fRPG);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_colour(c_black);
var _print = string_copy(text,1,textProgress);

if(responses[0] != -1) and (textProgress >= string_length(text))
{
	for(var i = 0; i < array_length(responses); i++)
	{
		_print += "\n";
		if(i == responseSelected) _print += "> ";
		_print += responses [i];
		if(i == responseSelected) _print += " <";
	}
}

draw_text((x1+x2)/2, y1+8, _print);
draw_set_color(c_white);
draw_text((x1+x2)/2, y1+7, _print);