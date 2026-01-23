/// @desc Initialize Game

// Steam
#macro STEAM_ENABLED false
#macro Steam:STEAM_ENABLED true

// Lock resolution
window_enable_borderless_fullscreen(true);
window_set_fullscreen(true);
surface_resize(application_surface,480,270);

// Shaders
global.uFlashPercent = shader_get_uniform(shFlash, "percent");
global.uFlashColor = shader_get_uniform(shFlash, "color");
global.uAlphaPercent = shader_get_uniform(shAlpha, "alpha");

// Saving
global.introLvl3 = 0;
global.noSave = false;
global.atBoss = false;

// Change volume
audio_master_gain(0.5);

Transition(rTitle,1);