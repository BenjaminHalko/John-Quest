/// @desc Initialize Game

// Steam
#macro STEAM_ENABLED false
#macro Steam:STEAM_ENABLED true

// Lock resolution
surface_resize(application_surface,480,270);

// Resize window
window_set_size(480*3, 270*3);
window_center();

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