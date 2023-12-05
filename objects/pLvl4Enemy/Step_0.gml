/// @desc

enableLive;

flash = Approach(flash,0,0.1);

if (knockback > 0) {
	knockback = Approach(knockback,0,1);
	x += lengthdir_x(knockback,knockbackDir);
	y += lengthdir_y(knockback,knockbackDir);
}