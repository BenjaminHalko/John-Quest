/// @desc Draw Map

surface_set_target(surf);
draw_clear_alpha(c_black, 0.5);
var _ox = surfW / 2;
var _oy = surfH / 2;
var _ca = dcos(camAngle);
var _sa = dsin(camAngle);
var _nodes = global.nodes;
var _count = array_length(_nodes);
var _tw = tileW;
var _th = tileH;
var _fh = floorH;
var _curFloor = _nodes[global.currentNode].flr;

// Pre-compute screen positions
var _screenX = array_create(_count);
var _screenY = array_create(_count);

for (var i = 0; i < _count; i++) {
	var _n = _nodes[i];
	var _dx = _n.x + 1 - (camX + 1) * 0.6;
	var _dy = _n.y + 1 - (camY + 1) * 0.6;
	// Rotate around camera
	var _rx = _dx * _ca - _dy * _sa;
	var _ry = _dx * _sa + _dy * _ca;
	// Floor offset (floor 0 and 1 same elevation, floor 2 elevated)
	var _fOff = (_n.flr >= 2) ? _fh : 0;
	// Iso project
	_screenX[i] = _ox + (_rx - _ry) * _tw;
	_screenY[i] = _oy + (_rx + _ry) * _th - _fOff + camFlr * floorH;
}

// Draw per floor: 0, 1 (same elevation), then 2 (above)
for (var _f = 0; _f <= 2; _f++) {
	var _alpha = (_f == _curFloor) ? 1.0 : 0.2;
	draw_set_alpha(_alpha);
	
	// Lines within this floor (only between visited nodes)
	draw_set_color(lineColor);
	for (var i = 0; i < _count; i++) {
		if (_nodes[i].flr != _f || !visited[i]) continue;
		for (var d = 0; d < 4; d++) {
			var _nb = _nodes[i].nextNode[d];
			if (_nb <= i || _nodes[_nb].flr != _f || !visited[_nb]) {
                if (_nb >= 0 and _nodes[_nb].hint and visited[10] and _nodes[_nb].flr == _curFloor) {
                    draw_set_alpha(0.5);
                    draw_line(_screenX[i], _screenY[i], _screenX[_nb], _screenY[_nb]);
                    draw_set_alpha(_alpha);
                }
                continue;
            }
			draw_line(_screenX[i], _screenY[i], _screenX[_nb], _screenY[_nb]);
		}
	}
	
	// Cubes on this floor (only visited)
	for (var i = 0; i < _count; i++) {
		if (_nodes[i].flr != _f || !visited[i] || i == global.currentNode) continue;
		drawCube(_screenX[i], _screenY[i], floorColors[_f]);
	}
}

// Cross-floor lines (staircase, only between visited nodes)
draw_set_alpha(0.5);
draw_set_color(stairColor);
for (var i = 0; i < _count; i++) {
	if (!visited[i]) continue;
	for (var d = 0; d < 4; d++) {
		var _nb = _nodes[i].nextNode[d];
		if (_nb <= i || _nodes[_nb].flr == _nodes[i].flr || !visited[_nb]) continue;
		draw_line(_screenX[i], _screenY[i], _screenX[_nb], _screenY[_nb]);
	}
}

// Current node on top
draw_set_alpha(1);
drawCube(_screenX[global.currentNode], _screenY[global.currentNode], currentColor);

// Questions
if (visited[10]) {
    for (var i = 0; i < _count; i++) {
        if (_nodes[i].hint and _nodes[i].flr == _curFloor and !visited[i] and i != global.currentNode) {
            draw_sprite(sMapHint, 0, _screenX[i], _screenY[i]);
        }
    }
}

surface_reset_target();

draw_surface_ext(surf, room_width - surfW, 0, 1, 1, 0, c_white, alpha);
