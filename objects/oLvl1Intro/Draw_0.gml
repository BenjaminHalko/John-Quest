/// @desc 

if (counter > 0 and counter % 2 == 0) {
	var _x = oCamera.x;
	var _y = oCamera.y;

	draw_set_font(fFont);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(_x, _y, "READY?");
}