/// @desc 

if (!isOnScreen()) instance_destroy();

if (point_in_circle(oPlayer.x,oPlayer.y,x,y,8)) {
	oPlayer.hurtPlayer(point_direction(x,y,oPlayer.x,oPlayer.y),32,0.5);
}