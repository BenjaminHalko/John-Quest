/// @desc 

var _len = sprite_height/2;
if (!dead and hovered) {
	DrawOutlineExt(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,false);
	if (oBossLvl3.type == 2) DrawOutlineExt(sBossLvl3Starbucks,0,x+lengthdir_x(_len,90+image_angle),y+lengthdir_y(_len,90+image_angle),1,1,image_angle,c_white,1,false);
}

draw_self();
if (oBossLvl3.type == 2) draw_sprite_ext(sBossLvl3Starbucks,0,x+lengthdir_x(_len,90+image_angle),y+lengthdir_y(_len,90+image_angle),1,1,image_angle,c_white,1);	