state = PlayerStateFree;
hitByAttack = -1;
lastState = state;

inputDirection = 0;
inputMagnitude = 0;

hSpeed = 0;
vSpeed = 0;
speedWalk = 2.5;
speedBonk = 1.25;
speedHook = 7.0;

distanceBonk = 40;
distanceBonkHeight = 20;
distanceHook = 128;

animType = PLAYERANIM.IDLE;

z = 0;
invulnerable = 0;
flash = 0;
animationEndScript = -1;
animationEnd = false;

hook = 0;
hookX = 0;
hookY = 0;
hookSize = sprite_get_width(sHookChain);

if (global.saveX != -1) {
	x = global.saveX;
	y = global.saveY;
}
direction = global.saveDir;

// custom
lastAnim = animType;
animTimer = 0;
walkWave = 0;
topShift = 0;
topShiftY = 0;
xDir = 0;
xscale = 1;
yscale = 1;
wHalf = sprite_width/2;

animPercent = 0;
swordCurve = animcurve_get_channel(PlayerLvl2Curves, "Sword");
swordDir = 1;

flashCol = [1,0,0];

autoMoveX = 0;
autoMoveY = 0;

// Hurt Player
hurtPlayer = function(_direction,_force,_damage)
{
	if (oPlayer.invulnerable <= 0 and global.playerHealth > 0)
	{
		//global.playerHealth = max(0, global.playerHealth-_damage);
		audio_play_sound(snPlayerDie, 1, false);
		
		with (oPlayer)
		{
			state = PlayerStateBonk;
			direction = _direction-180;
			moveDistanceRemaining = _force;
			ScreenShake(2,10);
			flash = 0.7;
			flashCol = [1,0,0];
			invulnerable = 60;
		}
		
		if (global.playerHealth <= 0)
		{
			audio_stop_sound(oLvl2Controller.music);
			invulnerable = 0;
			flash = 0;
			speedBonk /= 2;
			oCamera.follow = noone;
			oCamera.xTo = oCamera.x;
			oCamera.yTo = oCamera.y;
			layer_set_visible("Tiles", false);
			layer_set_visible("TilesAbove", false);
			layer_set_visible("TilesCave", false);
			layer_set_visible("TilesCaveBelow", false);
			layer_set_visible("TilesReallyAbove", false);
			layer_set_visible("TilesReallyAboveCave", false);
			with(all) {
				if (sprite_index != undefined and object_index != oPlayerLvl2) {
					visible = false;
				}
			}
			with(oPlayer) state = PlayerStateBonk;
		}
	}
}