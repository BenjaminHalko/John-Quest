/// @desc Update Map

// Mark current node as visited
if (!visited[global.currentNode]) {
    visited[global.currentNode] = true;
    visitedString = string_set_byte_at(visitedString, global.currentNode + 1, ord("Y"));
    Save("lvl3", "visited", visitedString);
}

var _ctrl = oNodeController;
var _curNode = global.nodes[global.currentNode];

if (global.movePercent != 1 && _ctrl.turnDir == 0) {
	// Forward movement - interpolate position between current and next node
	var _nextNode = global.nodes[_ctrl.nextNode];
	camX = lerp(_curNode.x, _nextNode.x, global.movePercent);
	camY = lerp(_curNode.y, _nextNode.y, global.movePercent);
	camFlr = lerp(_curNode.flr >= 2, _nextNode.flr >= 2, global.movePercent);
} else {
	// Stationary or turning - ease toward current node
	camX = _curNode.x;
	camY = _curNode.y;
	camFlr = _curNode.flr >= 2;
}

// Rotation
if (global.movePercent != 1 && _ctrl.turnDir != 0) {
	// Turning - ease toward target direction
	camAngle = ApproachCircleEase(camAngle, 90 * _ctrl.nextDir + 210, 5, 0.85);
} else {
	camAngle = ApproachCircleEase(camAngle, 90 * global.currentDir + 210, 5, 0.8);
}

if (!surface_exists(surf)) {
    surf = surface_create(surfW, surfH);
}


alpha = ApproachFade(alpha, displayMap, 0.2, 0.8);
