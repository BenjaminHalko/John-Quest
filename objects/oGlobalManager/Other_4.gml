/// @desc 

if (layer_exists("Walls")) {
	var _collisionLayer = layer_get_id("Walls");
	global.collisionMap = layer_tilemap_get_id(_collisionLayer);	
}

if (room == rLvl1) Save("global","lvl",0);
if (room == rLvl2) Save("global","lvl",1);
if (room == rLvl3) Save("global","lvl",2);
if (room == rLvl4) Save("global","lvl",3);