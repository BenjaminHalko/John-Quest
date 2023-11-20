/// @desc 

CalcAttack();

if (image_angle % 180 == 0) {
	depth = -y + lengthdir_y(32*image_yscale,image_angle+lerp(-90,90,image_index/image_number));
}