/// @desc Initialize Game

// GMLive
#macro enableLive if (live_call()) return live_result
instance_create_layer(0,0,layer,obj_gmlive);

sprite_set_live(sLvl1Boss, true);
sprite_set_live(sLvl1BossIris, true);

// Lock resolution
surface_resize(application_surface,480,270);

// Resize window
window_set_size(480*3, 270*3);
window_center();

// Shaders
global.uFlashPercent = shader_get_uniform(shFlash, "percent");
global.uFlashColor = shader_get_uniform(shFlash, "color");

global.uAlphaPercent = shader_get_uniform(shAlpha, "alpha");

// Change volume
audio_master_gain(0.5);

room_goto_next();