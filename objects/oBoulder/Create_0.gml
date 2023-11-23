/// @desc 

// Inherit the parent event
event_inherited();

if (Load("lvl2","rockDestroyed", false)) {
	instance_destroy(id, false);	
} else {
	layer_set_visible("TilesReallyAbove",false);
}