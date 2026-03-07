/// @desc Initialize Game

// Steam
#macro STEAM_ENABLED false
#macro Steam:STEAM_ENABLED true

// Lock resolution
window_enable_borderless_fullscreen(true);
window_set_fullscreen(true);
surface_resize(application_surface,480,270);

// Shaders
global.uFlashPercent = shader_get_uniform(shFlash, "percent");
global.uFlashColor = shader_get_uniform(shFlash, "color");
global.uAlphaPercent = shader_get_uniform(shAlpha, "alpha");

// Saving
global.introLvl3 = 0;
global.atBoss = false;
global.playerSpriteIsCustom = false;
global.playerCustomSprite = undefined;
if (STEAM_ENABLED) {
    global.playerSpriteIsCustom = Load("global", "face", false);
    global.playerCustomSprite = SteamGetPlayerIcon();
    if (!is_handle(global.playerCustomSprite)) {
        global.playerSpriteIsCustom = false;
    }
}

// Change volume
global.audioVol = Load("global", "audio", 0.5);
var _vol = log10(global.audioVol + 1) / log10(2);
audio_master_gain(_vol);

// VSync
if (os_type != os_operagx) {
    global.vsync = Load("global", "vsync", false);
    display_reset(0, global.vsync);
}

// Load Translations
LexiconLoad();

// Pausing
global.paused = false;

Transition(rTitle,1);