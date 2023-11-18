function Input() {
	keyUp = keyboard_check(vk_up);
	keyDown = keyboard_check(vk_down);
	keyRight = keyboard_check(vk_right);
	keyLeft = keyboard_check(vk_left);
	keyAction = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_shift);
	keyItemSelectUp = keyboard_check_pressed(ord("Z"));
	keyItemSelectDown = keyboard_check_pressed(ord("X"));
}