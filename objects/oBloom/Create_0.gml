/// @desc Init Bloom

surfacePing = surface_create(640,360);
surfacePong = surface_create(640,360);
uBlurVector = shader_get_uniform(shBlur, "blur_vector");


var _startGlow = "Background";
var _endGlow = "Walls";

layer_script_begin(layer_get_id(_startGlow),function() {
	if (event_type == ev_draw) and (event_number == 0) {
		surface_set_target(oBloom.surfacePing);
		draw_clear_alpha(c_black,0);
		camera_apply(view_camera[0]);
	}
});

layer_script_end(layer_get_id(_endGlow),function() {
	if (event_type == ev_draw) and (event_number == 0) {
		surface_reset_target();
	}
});