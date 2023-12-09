/// @desc 

enableLive;

var _x = camera_get_view_x(view_camera[0]);
var _y = camera_get_view_y(view_camera[0]);
var _barY = _y + 260 + 32 * (1 - percent);
var _rectHeight = 8;
var _barY1 = _barY-_rectHeight/2-1;
var _barY2 = _barY+_rectHeight/2-1;
var _barX1 = _x + 56;
var _barX2 = _x + 472;
var _barInnerX1 = _barX1+3;
var _barInnerX2 = _barX2-2;
var _barInnerY1 = _barY1+3;
var _barInnerY2 = _barY2-3;

var _col = c_white;

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
	draw_set_color(merge_color(_col, c_white, oBossLvl4Phase1.flash));
	draw_rectangle(_barInnerX1,_barInnerY1,lerp(_barInnerX1,_barInnerX2,healthDisplay),_barInnerY2,false);
}

if (percent == 1 and !point_in_rectangle(oBossLvl4Phase1.x,oBossLvl4Phase1.y,_x-32,_y-32,_x+480+32,_y+270+32)) {
	var _dir = point_direction(oCamera.x,oCamera.y,oBossLvl4Phase1.x,oBossLvl4Phase1.y);
	var _slope = dtan(_dir);

	var _x1 = _x+8;
	var _y1 = _y+8;
	var _x2 = _x+480-8;
	var _y2 = _y+260-8;
	var _yLeft = oCamera.y + (oCamera.x - _x1) * _slope;
	var _yRight = oCamera.y + (oCamera.x - _x2) * _slope;
	var _xTop = oCamera.x + (oCamera.y - _y1) / _slope;
	var _xBottom = oCamera.x + (oCamera.y - _y2) / _slope;

	var _xDraw, _yDraw;
	if (_y1 <= _yLeft and _yLeft <= _y2 and (_dir + 90) % 360 > 180) {
		_xDraw = _x1;
		_yDraw = _yLeft;
	} else if (_y1 <= _yRight and _yRight <= _y2 and (_dir + 90) % 360 < 180) {
		_xDraw = _x2;
		_yDraw = _yRight;
	} else if (_x1 <= _xTop and _xTop <= _x2 and _dir % 360 < 180) {
		_xDraw = _xTop;
		_yDraw = _y1;
	} else {
		_xDraw = _xBottom;
		_yDraw = _y2;
	}
	
	draw_sprite_ext(sBossLvl4UIArrow,0,_xDraw,_yDraw,1,1,_dir,c_white,1);
	draw_set_color(#f6071e);
	draw_set_font(fRetro);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	_dir = point_direction(oCamera.x,oCamera.y,_xDraw,_yDraw);
	draw_text(round(_xDraw-lengthdir_x(16,_dir)),round(_yDraw-lengthdir_y(16,_dir)),"!");
}