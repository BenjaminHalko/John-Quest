/// @desc Unpause

global.paused = false;

surface_free(appSurface);
buffer_delete(appBuffer);
