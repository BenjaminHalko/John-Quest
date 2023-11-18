/// @desc 

if (!is_undefined(playerX) and instance_exists(oPlayer)) {
	depth = oPlayer.depth + 1;
	oPlayer.x = playerX + oCamera.x;
	oPlayer.y = playerY + oCamera.y;
}
leading = false;
percent = 1;