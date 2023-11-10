/// @desc 

draw_set_font(fFont);
draw_set_color(c_white);

draw_set_alpha(0.5);
draw_text(16,16,currentCheckpoint+1);
draw_set_alpha(1);

if (debugTimer == 0) exit;

draw_text(48,16,"Copied");