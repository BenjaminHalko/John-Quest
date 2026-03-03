/// @desc Pause the game

// Copy the Screen
appSurface = surface_create(RESOLUTION_W, RESOLUTION_H);
surface_copy(appSurface, 0, 0, application_surface);
appBuffer = buffer_create(RESOLUTION_W * RESOLUTION_H * 4, buffer_fixed, 1);
buffer_get_surface(appBuffer, appSurface, 0);

// Deactivate All
specialObjs = [];
if (room == rLvl2) {
    with(oRockPile) {
        array_push(other.specialObjs, id);
    }
} else if (room == rLvl4) {
    with(oRockLvl4) {
        array_push(other.specialObjs, id);
    }
    with(pCollision) {
        array_push(other.specialObjs, id);
    }
}

instance_deactivate_all(true);
instance_activate_object(oGlobalManager);
instance_activate_object(__InputUpdateController);


if (room == rLvl3 or room == rLvl4) {
    setCursor(-1);
}

// Pause Menu
clickedUnpause = false;
buildingHeight = sprite_get_height(sTitleBuilding);
pausePercent = 0;
menu = [
    lexicon_text("menu.continue"),
    lexicon_text("menu.quit")
];
menuSelected = 0;

audio_pause_all();
audio_resume_sound(mLvl1Music);
audio_resume_sound(mLvl2Music);
audio_resume_sound(mLvl2MusicCave);
audio_resume_sound(mLvl2MusicBoss);
audio_resume_sound(mLvl3Music);
audio_resume_sound(mLvl3Music2);
audio_resume_sound(mLvl3Music3);
audio_resume_sound(mLvl3MusicBoss);
audio_resume_sound(snLvl4Ambience);
audio_resume_sound(mLvl4MusicBoss1);
audio_resume_sound(mLvl4MusicBoss2);

audio_play_sound(snPause, 1, false, 1, 0, 0.75);

global.paused = true;
