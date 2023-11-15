/// @desc 

if (instance_exists(oPlayer)) {
	depth = oPlayer.depth + 1;
	if (!is_undefined(playerX)) {
		oPlayer.x = playerX + oCamera.x;
		oPlayer.y = playerY + oCamera.y;
	}
}
leading = false;
percent = 1;