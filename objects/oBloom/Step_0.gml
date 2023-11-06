/// @desc Create Non-Existant Surfaces

if !surface_exists(surfacePing) surfacePing = surface_create(640,360);
if !surface_exists(surfacePong) surfacePong = surface_create(640,360);