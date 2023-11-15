/// @desc 

enableLive;

counter = 14;
lastTime = infinity;

playerY = oCamera.y - oCamera.viewHeightHalf - 32;

layersToHide = [
	"Hurt",
	"Platforms",
	"Springs",
	"Player",
	"TriangleJump"
];

for(var i = 0; i < array_length(layersToHide); i++) {
	layer_set_visible(layersToHide[i], false);
}

// Load Save Data
var _checkpointScale = Load("lvl1","saveScale", 1);
var _checkpointNum = Load("lvl1","saveNumber", 0);

/*
with (oCheckpoint) {
	if (checkpointNumber == _checkpointNum and scale == _checkpointScale) {
		oPlayer.xscale = scale;
		oPlayer.x = x+sprite_width/2;
		oPlayer.y = y+sprite_height-8;
		
		oCamera.snapToFollow();
		oCamera.boundary = noone;
		break;
	}
}
*/

oPlayer.autoMove = oPlayer.x;