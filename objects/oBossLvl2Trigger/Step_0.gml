/// @desc 

if (active == 0 and place_meeting(x,y,oPlayer)) {
	active = 1;
	oPlayer.state = PlayerStateAutoMove;
	oPlayer.autoMoveX = oPlayer.x;
	oPlayer.autoMoveY = y - 32;
	audio_sound_gain(oLvl2Controller.music, 0, 1800);
}

if (active == 1 and audio_sound_get_gain(oLvl2Controller.music) <= 0.4) {
	audio_stop_sound(oLvl2Controller.music);
	layer_set_visible("TilesCaveAbove", false);
	active = 2;
	
	instance_create_layer(x+16,y-8,"Instances",oExplode);
	call_later(5,time_source_units_frames,function() { instance_create_layer(x+2,y-2,"Instances",oExplode); });
	call_later(10,time_source_units_frames,function() { instance_create_layer(x+30,y-2,"Instances",oExplode); });
	call_later(15,time_source_units_frames,function() { instance_create_layer(x+16,y+6,"Instances",oExplode); });
	ScreenShake(5, 40);
}

if (active == 2 and !audio_is_playing(snExplosionShort)) {
	oLvl2Controller.music = audio_play_sound(mLvl2MusicBoss,1,true);
	audio_sound_loop_start(oLvl2Controller.music, 60 / 140 * 8 * 4);
	instance_create_layer(x+16,y-196,"Instances",oBossLvl2);
	active++;
}

if (active == 3 and !oBossLvl2.intro and oBossLvl2.eyeExpandPercent == 0) {
	audio_play_sound(snBossLvl1Roar,1,false);
	active++;
	ScreenShake(15,120);
	wait = 120;
}

if (active == 4 and --wait <= 0) {
	instance_create_layer(0,0,layer,oBossLvl2UI);
	oPlayer.state = PlayerStateFree;
	instance_destroy();	
}