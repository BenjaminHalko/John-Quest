function BloomStart() {
	if (event_type == ev_draw and event_number == ev_draw_normal) {
		surface_set_target(oBloom.surfacePing);
		draw_clear_alpha(c_black,0);
		camera_apply(view_camera[0]);
	}
}

function BloomDraw() {
	if (event_type == ev_draw and event_number == ev_draw_normal) {
		surface_reset_target();
		
		var _x = camera_get_view_x(view_camera[0]);
		var _y = camera_get_view_y(view_camera[0]);

		with(oBloom) {
			surface_set_target(surfacePong);
			draw_clear_alpha(c_black, 0);
			shader_set(shBlur);
			shader_set_uniform_f(uBlurVector,0,1);
			draw_surface(surfacePing,0,0);
			surface_reset_target();

			shader_set_uniform_f(uBlurVector,1,0);
			draw_surface_ext(surfacePong,_x,_y,1,1,0,make_color_hsv(0,0,255*0.7),1);
			shader_reset();

			gpu_set_blendmode(bm_add);
			draw_surface_ext(surfacePing,_x,_y,1,1,0,make_color_hsv(0,0,255*0.7),1);
			gpu_set_blendmode(bm_normal);
		}
	}
}