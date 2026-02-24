function SteamGetPlayerIcon(){
    var _img = steam_get_user_avatar(steam_get_user_steam_id(), steam_user_avatar_size_small);
    
    // Check if avatar is ready
    if (_img > 0)
    {
        var _dims = steam_image_get_size(_img);
        var _buff_size = _dims[0] * _dims[1] * 4;
    
        var _l_cols = buffer_create(_buff_size, buffer_fixed, 1);
    
        var _l_ok = steam_image_get_rgba(_img, _l_cols, _buff_size);
    
        if(!_l_ok)
        {
            buffer_delete(_l_cols);
            exit;
        }
    
        var _l_surf = surface_create(_dims[0], _dims[1]);
        buffer_set_surface(_l_cols, _l_surf, 0);
        
        var _surfFinal = surface_create(16, 16);
        surface_set_target(_surfFinal);
        draw_surface_ext(_l_surf, 0, 0, 16/_dims[0], 16/_dims[1], 0, c_white, 1);
        surface_reset_target();
    
        var _sprite = sprite_create_from_surface(_surfFinal, 0, 0, 16, 16, false, false, 8, 8);

        surface_free(_l_surf);
        surface_free(_surfFinal);
        buffer_delete(_l_cols);
        
        return _sprite;
    }
    
    return undefined;
}