/// @desc Init Bloom

surfacePing = surface_create(480,270);
surfacePong = surface_create(480,270);
uBlurVector = shader_get_uniform(shBlur, "blur_vector");

if (room == rLvl1) {
	layer_script_begin("Background", BloomStart);
	layer_script_begin("Bloom", BloomDraw);
} else if (room == rLvl2) {
	
}