/// @desc Initialize Game

// GMLive
#macro enableLive if (live_call()) return live_result
instance_create_layer(0,0,layer,obj_gmlive);

// Lock resolution
surface_resize(application_surface,480,270);

// Resize window
window_set_size(480*3, 270*3);
window_center();

room_goto_next();