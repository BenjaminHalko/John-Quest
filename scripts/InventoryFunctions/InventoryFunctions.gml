function DrawOutline(_sprite, _index, _x, _y) {
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashColor,1,1,1);
	shader_set_uniform_f(global.uFlashPercent,1);
	draw_sprite(_sprite,_index,_x+1,_y+1);
	draw_sprite(_sprite,_index,_x+1,_y-1);
	draw_sprite(_sprite,_index,_x-1,_y+1);
	draw_sprite(_sprite,_index,_x-1,_y-1);
	shader_reset();
	draw_sprite(_sprite,_index,_x,_y);
}