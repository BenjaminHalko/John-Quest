/// @desc 

if (!is_undefined(global.playerCustomSprite))
    sprite_delete(global.playerCustomSprite);

if (STEAM_ENABLED) {
    steam_shutdown();
}
