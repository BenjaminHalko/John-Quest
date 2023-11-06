/// @desc
oPlayer.stopFalling = true;
with(instance_create_layer(x,y-600,"Checkpoint",oFallingController)) {
	wallY = other.y - 384 - 32 * 8;
	music = oCutsceneWall.music;
}
oPlayer.vspLock = false;
oPlayer.y -= oPlayer.vsp;
oPlayer.vsp = 0;
oPlayer.vsp_final = 0;
oCamera.stopFollowing = true;
oCamera.yTo = oPlayer.y-100;
layer_enable_fx("UnderwaterEffect",false);
instance_destroy(oCutsceneWall);
instance_destroy();