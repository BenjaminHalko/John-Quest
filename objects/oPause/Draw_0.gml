/// @desc Draw Paused Menu

var _camX = camera_get_view_x(view_camera[0]);
var _camY = camera_get_view_y(view_camera[0]);
var _mat = matrix_build(_camX, _camY, 0, 0, 0, 0, 1, 1, 1);
matrix_set(matrix_world, _mat);

draw_clear(c_black);
draw_surface_ext(appSurface, 0, 0, 1, 1, 0, c_white, 1 - pausePercent * 0.9);

draw_sprite(sTitle,0,floor((RESOLUTION_W-180)/2),lerp(-200, 24, pausePercent));
draw_sprite(sTitleBuilding, 1, RESOLUTION_W, RESOLUTION_H + buildingHeight * (1-pausePercent));

var _playerSprite = global.playerSpriteIsCustom ? global.playerCustomSprite : sPlayerLvl1;
draw_sprite(_playerSprite,0,350,RESOLUTION_H-buildingHeight*pausePercent+24);

draw_set_font(global.fontRetro);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _menuX = 100;
var _menuY = 176;
var _blinkWave = Wave(0,2,0.5,0);
var _textOffset = global.fontRetroYOffset;

draw_set_alpha(pausePercent);
for(var i = 0; i < array_length(menu); i++) {
    draw_text(_menuX,_menuY+16*i+_textOffset,menu[i]);
}
draw_sprite(sTitleCursor,0,_menuX-16+_blinkWave,_menuY+menuSelected*16);
draw_set_alpha(1);

matrix_set(matrix_world, matrix_build_identity());
