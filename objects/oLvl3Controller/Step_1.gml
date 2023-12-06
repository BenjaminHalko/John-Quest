/// @desc 

// Input
global.mx = device_mouse_x_to_gui(0);
global.my = device_mouse_y_to_gui(0);
global.clicked = mouse_check_button_pressed(mb_left);

// Cursors
if (windowWidth != window_get_width() or windowHeight != window_get_height()) {
	windowWidth = window_get_width();
	windowHeight = window_get_height();
	createCursors();
}