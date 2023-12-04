/// @desc 

if (behindPlayer and instance_exists(oPlayer)) {
	depth = -100000;
	oPlayer.depth = depth - 1;
	oPlayer.changeDepth = false;
}
leading = false;
percent = 1;