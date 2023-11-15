/// @desc 

enableLive;

oPlayer.autoMove = oPlayer.x;

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