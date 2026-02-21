/// @desc Init Map

// Iso projection
tileW = 8;
tileH = 4;
floorH = 32;

// Cube size
cubeW = 4;
cubeH = 2;
cubeD = 3;

// Floor colors: [outside, F1, F2]
floorColors = [ #5a7a5a, #6a6a9a, #4D669A];
currentColor = #ffdd44;
lineColor = c_ltgrey;
stairColor = #8888aa;

// Visited nodes
visited = array_create(array_length(global.nodes));
visitedString = Load("lvl3", "visited", string_repeat("N", array_length(global.nodes)));
for(var i = 0; i < array_length(global.nodes); i++) {
    visited[i] = (string_char_at(visitedString, i+1) == "Y");
}
visited[global.currentNode] = true;
string_set_byte_at(visitedString, global.currentNode + 1, ord("Y"));

// Camera tracking
var _node = global.nodes[global.currentNode];
camX = _node.x;
camY = _node.y;
camFlr = _node.flr >= 2;


surfW = 100;
surfH = 80;
surf = surface_create(surfW, surfH);

camAngle = global.currentDir * 90 + 210;


displayMap = true;
alpha = 1;

if (global.isBattle) {
    displayMap = false;
    alpha = 0;
}

/// @func drawCube(_cx, _cy, _col)
drawCube = function(_cx, _cy, _col) {
	var _w = cubeW;
	var _h = cubeH;
	var _d = cubeD;
	
	// Top face
	draw_set_color(_col);
	draw_triangle(_cx, _cy - _h, _cx + _w, _cy, _cx, _cy + _h, false);
	draw_triangle(_cx, _cy - _h, _cx - _w, _cy, _cx, _cy + _h, false);
	
	// Left face
	draw_set_color(merge_color(_col, c_black, 0.3));
	draw_triangle(_cx - _w, _cy, _cx, _cy + _h, _cx, _cy + _h + _d, false);
	draw_triangle(_cx - _w, _cy, _cx - _w, _cy + _d, _cx, _cy + _h + _d, false);
	
	// Right face
	draw_set_color(merge_color(_col, c_black, 0.5));
	draw_triangle(_cx + _w, _cy, _cx, _cy + _h, _cx, _cy + _h + _d, false);
	draw_triangle(_cx + _w, _cy, _cx + _w, _cy + _d, _cx, _cy + _h + _d, false);
};
