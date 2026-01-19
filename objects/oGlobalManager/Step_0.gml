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

if (keyboard_check_pressed(vk_f11) and os_type != os_operagx) {
    window_set_fullscreen(!window_get_fullscreen());
}
