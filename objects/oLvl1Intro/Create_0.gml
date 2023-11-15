/// @desc 

oPlayer.autoMove = oPlayer.x;

counter = 100;
lastTime = 0;

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