/// @desc 

if (!activate) {
	other.boss = true;
	other.autoMove = playerTarget;
	activate = true;
	oBackground.bossMode = true;
	
	layer_script_begin("Walls", function() {
        if (global.paused) exit;
		shader_set(shAlpha);
		shader_set_uniform_f(global.uAlphaPercent, 1-oBackground.bossTransitionPercent);
	});
	
	layer_script_end("SemiSolidBridge", function() {
        if (global.paused) exit;
		shader_reset();
	});
}