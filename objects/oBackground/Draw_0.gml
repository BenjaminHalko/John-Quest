/// @desc 

enableLive;

var _camX = camera_get_view_x(view_camera[0]);
var _camY = camera_get_view_y(view_camera[0]);

for(var i = 0; i < array_length(particles); i++) {
	if (particles[i].audioReactive) {
		
	} else {
		draw_set_color(c_fuchsia);
		var _x = particles[i].x+_camX;
		var _y = particles[i].y+_camY;
		draw_point(_camX+particles[i].x-(_camX*particles[i].paralax % 480), _y);
	}
}