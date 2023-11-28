/// @desc 

var _x = camera_get_view_x(view_camera[0]);
var _y = camera_get_view_y(view_camera[0]);
var _barY = _y + 260 + 32 * (1 - percent) + 32 * oBossLvl2.deadPercent;
var _rectHeight = 8;
var _barY1 = _barY-_rectHeight/2-1;
var _barY2 = _barY+_rectHeight/2-1;
var _barX1 = _x + 56;
var _barX2 = _x + 472;
var _barInnerX1 = _barX1+3;
var _barInnerX2 = _barX2-2;
var _barInnerY1 = _barY1+3;
var _barInnerY2 = _barY2-3;

var _col = c_orange;

draw_set_font(fRetro);
draw_set_color(_col);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_text(_x+8,_barY,"BOSS:");
draw_set_color(c_black);
draw_rectangle(_barX1,_barY1,_barX2,_barY2,false);
draw_set_color(_col);
draw_rectangle(_barX1+1,_barY1+1,_barX2,_barY2-0.5,true);
if (healthDisplay > 0) {
	draw_set_color(merge_color(_col, c_white, oBossLvl2.flash));
	draw_rectangle(_barInnerX1,_barInnerY1,lerp(_barInnerX1,_barInnerX2,healthDisplay),_barInnerY2,false);
}