/// @desc 

gotSword = (global.questStatusHat == 2 and !global.playerItemUnlocked[ITEM.SWORD]);

image_xscale = 0;
image_yscale = 0;

sprite_index = gotSword ? sSword : sBomb;
if (gotSword) image_speed = 0;

spd = 1;
wait = 60;

x = oPlayer.x;
y = oPlayer.y - 64;

ystart = y;