/// @desc 

if (behindPlayer and instance_exists(oPlayer)) {
	depth = -100000;
	oPlayer.depth = depth - 1;
	oPlayer.changeDepth = false;
}
if (room == rCredits) {
	depth = layer_get_depth("Player")+1;	
}
leading = false;
percent = 1;