/// @desc 

if (place_meeting(x,y,oPlayer) and active == 0) {
	active = 1;
	oPlayer.state = PlayerStateAutoMove;
	oPlayer.autoMoveX = oPlayer.x;
	oPlayer.autoMoveY = y - 56;
	audio_sound_gain(oLvl2Controller.music,0,2000);
}

if (active == 1 and audio_sound_get_gain(oLvl2Controller.music) <= 0 and !audio_is_playing(snBossLvl1Roar)) {
	audio_stop_sound(mLvl2Music);
	audio_play_sound(snBossLvl1Roar,1,false,0.5,0,0.9);
	ScreenShake(6,230);
	active = 2;
	layer_set_visible("TilesReallyAbove",false);
	layer_set_visible("TilesReallyAboveCave",false);
	layer_set_visible("Tiles",false);
}

if (active == 2 and (!audio_is_playing(snBossLvl1Roar)) and --wait <= 0) {
	oLvl2Controller.music = audio_play_sound(mLvl2MusicCave, 1, true);
	oPlayer.state = PlayerStateFree;
	Save("lvl2","inCave",true);
	global.saveX = x + 8;
	global.saveY = oPlayer.y;
	global.saveDir = 90;
	SaveLvl2();
	instance_destroy();
}