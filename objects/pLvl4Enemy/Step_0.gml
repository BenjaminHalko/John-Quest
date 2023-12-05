/// @desc

flash = Approach(flash,0,0.1);

if (knockback > 0) {
	knockback = Approach(knockback,0,0.1);
	x += lengthdir_x(2,knockbackDir);
	y += lengthdir_y(2,knockbackDir);
}