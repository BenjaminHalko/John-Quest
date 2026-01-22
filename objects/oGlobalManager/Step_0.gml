/// @desc Manage game

if (STEAM_ENABLED) {
    steam_update();   
}

if (InputPressed(INPUT_VERB.BACK)) {
    if (room == rTitle) {
        game_end();
    } else {
        Transition(rTitle);
    }
}

if (os_type != os_operagx and (keyboard_check_pressed(vk_f4) or keyboard_check_pressed(vk_f11))) {
    window_set_fullscreen(!window_get_fullscreen());
}
