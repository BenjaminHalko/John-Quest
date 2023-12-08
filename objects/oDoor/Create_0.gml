/// @desc

if (createDoor) {
	instance_create_layer(x+lengthdir_x(sprite_width,image_angle),y+lengthdir_y(sprite_width,image_angle),layer,oDoor, {
		createDoor: false,
		doorNumber: doorNumber,
		image_angle: image_angle+180,
		image_xscale: image_xscale/2
	});
	image_xscale /= 2;
}

activated = false;
spd = 0;