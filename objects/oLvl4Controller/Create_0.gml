/// @desc 

// Cursor
windowWidth = window_get_width();
windowHeight = window_get_height();
global.cursors = [];
global.currentCursorType = CURSOR.LVL4;
createCursors();

// Get all sprite backgrounds
bgElements = [];
var _layers = layer_get_all();

for(var i = 0; i < array_length(_layers); i++) {
	var _name = layer_get_name(_layers[i]);
	if (string_starts_with(_name,"BG_")) {
		var _depth = real(string_split(_name,"_")[1]);
		var _ele = layer_get_all_elements(_layers[i]);
		for(var j = 0; j < array_length(_ele); j++) {
			var _x = layer_sprite_get_x(_ele[j]);
			var _y = layer_sprite_get_y(_ele[j]);
			array_push(bgElements, {
				x: _x,
				y: _y,
				element: _ele[j],
				depth: _depth
			});
		}
	}
}

// Save
Save("global","lvl",3);