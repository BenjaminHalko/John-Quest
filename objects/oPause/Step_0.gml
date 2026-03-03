/// @desc Pause Menu

if (instance_exists(oTransition)) {
    exit;
}

if (clickedUnpause) {
    pausePercent = Approach(pausePercent, 0, 0.1);
    if (pausePercent <= 0) {
        instance_activate_all();
        if (room == rLvl2) {
            instance_deactivate_object(oRockPile);
        } else if (room == rLvl4) {
            instance_deactivate_object(oRockLvl4);
            instance_deactivate_object(pCollision);
        }
        
        array_foreach(specialObjs, instance_activate_object);
        audio_resume_all();
        instance_destroy();
    }

    exit;
}

pausePercent = ApproachFade(pausePercent, 1, 0.1, 0.7);

if (!surface_exists(appSurface)) {
    appSurface = surface_create(RESOLUTION_W, RESOLUTION_H);
    buffer_set_surface(appBuffer, appSurface, 0);
}

// Menu
var _input = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);

if (_input != 0) {
    menuSelected = 1 - menuSelected;
    audio_play_sound(snBlip,1,false);
}

if (InputPressed(INPUT_VERB.ACCEPT)) {
    if (menuSelected == 0) {
        clickedUnpause = true;
        audio_play_sound(snPause, 1, false, 1, 0, 0.6);
    } else {
        Transition(rTitle);
    }
}

if (InputPressed(INPUT_VERB.BACK)) {
    clickedUnpause = true;
    audio_play_sound(snPause, 1, false, 1, 0, 0.6);
}
