/// @desc 

// Cursor
windowWidth = window_get_width();
windowHeight = window_get_height();
global.cursors = [];
global.currentCursorType = CURSOR.LVL4;
if (global.introLvl3 != 2 and !Load("lvl4","seenIntro",false)) {
	global.introLvl3 = 1;
	Transition(rLvl3Intro,1);
	room_goto(rLvl3Intro);
} else {
	createCursors();
}

// Get all sprite backgrounds
bgElements = [];
var _layers = layer_get_all();

for(var i = 0; i < array_length(_layers); i++) {
	var _name = layer_get_name(_layers[i]);
	if (string_starts_with(_name,"BG_")) {
		var _split = string_split(_name,"_");
		var _depth = real(string_split(_name,"_")[1]);
		if (array_length(_split) > 2) {
			array_push(bgElements, {
				x: 0,
				y: 0,
				depth: _depth,
				element: _layers[i],
				isBG: true
			});
		} else {
			var _ele = layer_get_all_elements(_layers[i]);
			for(var j = 0; j < array_length(_ele); j++) {
				var _x = layer_sprite_get_x(_ele[j]);
				var _y = layer_sprite_get_y(_ele[j]);
				array_push(bgElements, {
					x: _x,
					y: _y,
					element: _ele[j],
					depth: _depth,
					isBG: false
				});
			}
		}
	}
}

// Add collision to sprites
var _layerEnv = layer_get_id("Environment");
var _layer = layer_create(layer_get_depth(_layerEnv)-1,"Collision");
var _elements = layer_get_all_elements(_layerEnv);
for(var i = 0; i < array_length(_elements); i++) {
	var _ele = _elements[i];
	var _x = layer_sprite_get_x(_ele);
	var _y = layer_sprite_get_y(_ele);
	instance_create_layer(_x,_y,"Collision",pCollision,{
		sprite_index: layer_sprite_get_sprite(_ele),
		image_xscale: layer_sprite_get_xscale(_ele),
		image_yscale: layer_sprite_get_yscale(_ele),
		image_angle: layer_sprite_get_angle(_ele)
	});
}
layer_destroy(_layerEnv);