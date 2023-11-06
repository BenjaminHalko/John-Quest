/// @desc 

if (layer_exists("Walls")) {
	var _collisionLayer = layer_get_id("Walls");
	global.collisionMap = layer_tilemap_get_id(_collisionLayer);	
}