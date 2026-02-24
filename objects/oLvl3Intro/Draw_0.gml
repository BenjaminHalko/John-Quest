/// @desc 

if (lvl4) {
	var _scale = min(1,percent*2);
    if (global.playerSpriteIsCustom) {
        draw_sprite_ext(global.playerCustomSprite,0,128,224-300*percent,_scale,_scale,0,c_white,1);
        draw_sprite_ext(sPlayerLvl4,1,128,224-300*percent,_scale,_scale,0,c_white,1);
    } else {
        draw_sprite_ext(sPlayerLvl4,0,128,224-300*percent,_scale,_scale,0,c_white,1);
    }
	draw_sprite_ext(sPlayerPropeller,index,128,224-300*percent-12*_scale,_scale,_scale,0,c_white,1);
} else {
	var _scale = (0.5 - max(percent-0.5,0))*2;
    var _playerSprite = global.playerSpriteIsCustom ? global.playerCustomSprite : sPlayerLvl1;
	draw_sprite_ext(_playerSprite,0,128,224-300*(1-percent),_scale,_scale,index,c_white,1);
}