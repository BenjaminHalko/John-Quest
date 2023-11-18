/// @desc 

draw_sprite_ext(sPlayerShadow,0,floor(x),floor(y),xscale,1,0,c_white,1);

// Hookshot (before player)
if (state == PlayerStateHook) and (direction == 90) DrawHookChain();

if(invulnerable != 0) and ((invulnerable mod 8 < 2) == 0) and (flash == 0) {
	// skip draw	
} else {
	if (flash != 0) {
		shader_set(shFlash);
		shader_set_uniform_f(global.uFlashPercent,flash);
		shader_set_uniform_f(global.uFlashColor,1,0,0);
	}

	draw_sprite_pos(sprite_index,image_index,
		floor(x)-wHalf*xscale+topShift,floor(y)-wHalf*2*yscale,
		floor(x)+wHalf*xscale+topShift,floor(y)-wHalf*2*yscale,
		floor(x)+wHalf*xscale,floor(y),
		floor(x)-wHalf*xscale,floor(y),
	image_alpha);

	if (flash != 0) shader_reset();
}

//Hookshot (after player)
if (state == PlayerStateHook) and (direction != 90) DrawHookChain();

function DrawHookChain()
{
	var _originX = floor(x);
	var _originY = floor(y)-7;
	
	var _chains = hook div hookSize;
	var _hookDirX = sign(hookX);
	var _hookDirY = sign(hookY);
	for(var i = 0; i < _chains; i++)
	{
		draw_sprite(
		sHookChain,
		0,
		_originX+hookX-(i*hookSize*_hookDirX),
		_originY+hookY-(i*hookSize*_hookDirY));
	}
	draw_sprite(sHookBlade,direction div 90,_originX+hookX,_originY+hookY);
}