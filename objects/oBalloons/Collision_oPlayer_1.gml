if image_index != 1
{
	action_effect(3, 48, 48, 1, 16711808, 0);
	action_effect(3, 16, 16, 1, 4194304, 0);
	action_effect(3, 48, 16, 1, 10485760, 0);
	action_effect(3, 16, 48, 1, 8388672, 0);
	audio_play_sound(snBalloons, 0, false);
	pitch = random_range(0.5,2);
	audio_sound_pitch(snBalloons,pitch);
	image_index = 1;
	alarm[0] = 60*5;
	
	if instance_exists(oDamageTutorialController) {
		with(instance_create_layer(x,y,layer,oLaserGood)) {
			image_angle = point_direction(x,y,oDamageTutorialController.x,oDamageTutorialController.y);
			direction = image_angle;
			speed = 12;
			targetScale = 8;
		}
		instance_destroy();
	} else if instance_exists(oBoss) {
		if ending {
			oPlayer.autoMove = x+32;
			oCamera.xOffset = -170;
		}
		with(instance_create_layer(x,y,layer,oLaserGood)) {
			image_angle = point_direction(x,y,oBoss.x,oBoss.y);
			direction = image_angle;
			speed = 12;
			targetScale = 8;
		}
		instance_destroy();
	}
}
