/// @desc

if oPlayer.vspLock or oPlayer.autoMove != undefined exit;
if oPlayer.stopFalling {
	if !audio_is_playing(snDeath) audio_play_sound(snDeath,1,false);
	oPlayer.tempHurt = 30;
} else HurtPlayer();