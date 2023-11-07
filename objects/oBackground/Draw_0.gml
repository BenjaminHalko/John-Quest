/// @desc 

enableLive;

var _camX = camera_get_view_x(view_camera[0]);
var _camY = camera_get_view_y(view_camera[0]);
var _camW = camera_get_view_width(view_camera[0]);
var _camH = camera_get_view_height(view_camera[0]);


for(var i = 0; i < array_length(particles); i++) {
	draw_set_alpha(1-max(0,(abs(particles[i].y - 270/2) - 270/2)/30));
	var _paralax = lerp(0.95, 0.2, particles[i].spd);
	var _x = Wrap(particles[i].x+_camX*_paralax,_camX, _camX+_camW);
	var _y = Wrap(particles[i].y+_camY*_paralax,_camY, _camY+_camH);
	if (particles[i].audioReactive) {
		draw_set_color(merge_color(c_fuchsia, c_aqua, particles[i].pulse/6));
		draw_rectangle(_x-particles[i].pulse,_y-particles[i].pulse,_x+1+particles[i].pulse,_y+1+particles[i].pulse,false);
	} else  {
		draw_set_color(c_fuchsia);
		if (particles[i].spd >= 0.5)
			draw_rectangle(_x,_y,_x+1,_y+1,false);
		else
			draw_point(_x,_y);
	}
}
draw_set_alpha(1);