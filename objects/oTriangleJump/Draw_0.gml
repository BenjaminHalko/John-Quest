/// @desc Draw Triangle

function drawTriangle(_length) {
	var _rot = -outlineRotation/2;
	var _x = x-1;
	var _y = y-1;
	
	draw_triangle(
		_x + lengthdir_x(_length, _rot), _y + lengthdir_y(_length, _rot),
		_x + lengthdir_x(_length, _rot+120), _y + lengthdir_y(_length, _rot+120),
		_x + lengthdir_x(_length, _rot+240), _y + lengthdir_y(_length, _rot+240),
	false);
}

// Variables
var _col = merge_color(c_white, #65FFFF, hoverCurvePercent);

// Outline

var _alpha = min(1,(3 - breakCurvePercent));
draw_sprite_ext(sTriangleJump,1,x,y,1,1,outlineRotation,_col,_alpha);

// Draw triangle
var _scale = breakCurvePercent + hoverCurvePercent * 0.1;
draw_set_alpha(_alpha);
draw_set_color(_col);
drawTriangle(8*_scale);

draw_set_color(c_black);
drawTriangle(4*_scale);
draw_set_alpha(1);