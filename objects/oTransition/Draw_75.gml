/// @desc

if (transitionType != TRANSITION.FADE) exit;

draw_set_color(c_black);
draw_set_alpha(clamp(percent,0,1));
draw_rectangle(0,0,room_width,room_height,false);
draw_set_alpha(1);
