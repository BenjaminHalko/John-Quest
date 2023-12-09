/// @desc 

enableLive;

allowMovement = true;

// spd
hsp = 0;
vsp = 0;
movespd = 4.5;

// item
shotTimer = 0;
knockBack = 0;
itemPercent = 0;
changeItem = false;
item = 0;
itemSprites = [
	sPlayerLaserGun,
	sPlayerCannon
];
itemCircleNum = sprite_get_number(sPlayerItemCircle);
itemCurve = animcurve_get_channel(PlayerItemCurves,"item");

// health
hp = 8;
hurt = 0;
explosions = 0;
explosionWait = 30;

// sprite
propellerSpd = sprite_get_speed(sPlayerPropeller) / 60;
propellerNum = sprite_get_number(sPlayerPropeller);
propellerIndex = 0;
yscale = 1;