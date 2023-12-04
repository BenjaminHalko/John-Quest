function Input() {
	keyUp = keyboard_check(vk_up) or keyboard_check(ord("W"));
	keyDown = keyboard_check(vk_down) or keyboard_check(ord("S"));
	keyRight = keyboard_check(vk_right) or keyboard_check(ord("D s"));
	keyLeft = keyboard_check(vk_left) or keyboard_check(ord("A"));
	keyAction = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter);
	keySecondary = keyboard_check_pressed(vk_shift);
}