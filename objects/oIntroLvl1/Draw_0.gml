/// @desc 

enableLive;

if (counter > 0 and counter % 2 == 1) {
	var _x = oCamera.x;
	var _y = oCamera.y;

	draw_set_font(fFont);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(_x, _y, "READY?");
}

if (counter <= 0) {
	draw_sprite_ext(sPlayer, 0, oPlayer.x, playerY - 8, 0.5, 2, 0, c_white, 1);	
}