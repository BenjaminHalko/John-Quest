/// @desc

var _topShift = hsp*topShiftPercent;
var _wHalf = wHalf*xscale/yscale;

shader_set(shFlash);
shader_set_uniform_f(uPercent,flash);
draw_sprite_pos(sprite_index,image_index,

x-_wHalf+_topShift,y-wHalf*2*yscale+wHalf,
x+_wHalf+_topShift,y-wHalf*2*yscale+wHalf,
x+_wHalf,y+wHalf,
x-_wHalf,y+wHalf,

image_alpha);
shader_reset();