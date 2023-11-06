/// @desc Init Bloom

surfacePing = surface_create(480,270);
surfacePong = surface_create(480,270);
uBlurVector = shader_get_uniform(shBlur, "blur_vector");

layer_script_begin(layer_get_id("Background"),function() {
	if (event_type == ev_draw) and (event_number == 0) {
		surface_set_target(oBloom.surfacePing);
		draw_clear_alpha(c_black,0);
		camera_apply(view_camera[0]);
	}
});

layer_script_begin(layer_get_id("Bloom"),function() {
	if (event_type == ev_draw) and (event_number == 0) {
		surface_reset_target();
	}
});