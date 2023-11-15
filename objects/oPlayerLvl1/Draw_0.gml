/// @desc

var _topShift = hsp*topShiftPercent;
var _wHalf = wHalf*xscale/yscale;

shader_set(shFlash);
shader_set_uniform_f(global.uFlashPercent,flash);
shader_set_uniform_f(global.uFlashColor,0,1,1);

if rotation == 0 {
	draw_sprite_pos(sprite_index,image_index,

	x-_wHalf+_topShift,y-wHalf*2*yscale+wHalf,
	x+_wHalf+_topShift,y-wHalf*2*yscale+wHalf,
	x+_wHalf,y+wHalf,
	x-_wHalf,y+wHalf,

	image_alpha);
} else {
	draw_sprite_pos(sprite_index,image_index,

	x+lengthdir_x(diagLen,135+rotation)*xscale,y+lengthdir_y(diagLen,135+rotation),
	x+lengthdir_x(diagLen,45+rotation)*xscale,y+lengthdir_y(diagLen,45+rotation),
	x+lengthdir_x(diagLen,-45+rotation)*xscale,y+lengthdir_y(diagLen,-45+rotation),
	x+lengthdir_x(diagLen,-135+rotation)*xscale,y+lengthdir_y(diagLen,-135+rotation),

	image_alpha);	
}
shader_reset();