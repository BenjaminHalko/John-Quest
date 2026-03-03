/// @desc Manage game

if (STEAM_ENABLED) {
    steam_update();   
}

if (
    room != rTitle and
    !instance_exists(oTransition) and
    !global.paused and
    InputPressed(INPUT_VERB.BACK)
) {
    if (room == rCredits) {
        Transition(rTitle);
    } else {
        instance_create_depth(0, 0, 0, oPause);
    }
}

if (os_type != os_operagx and (keyboard_check_pressed(vk_f4) or keyboard_check_pressed(vk_f11))) {
    window_set_fullscreen(!window_get_fullscreen());
}
