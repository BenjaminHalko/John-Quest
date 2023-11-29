/// @desc 

enableLive;

var _rectH = 8;
var _rectY = lerp(-_rectH*(!teleportAppear),sprite_height,disappearPercent)-1;
var _rectCol1 = #BB00FF;
var _rectCol2 = #5500FF;

_rectCol1 = merge_color(_rectCol1,c_aqua,deadPercent);
_rectCol2 = merge_color(_rectCol2,c_blue,deadPercent);

draw_sprite_ext(sBossLvl2Shadow,0,x,y,image_xscale,image_yscale,0,merge_color(c_black,_rectCol1,min(1,eyeExpandPercent*3)),lerp(75/255,0.8,min(1,eyeExpandPercent*3))*min(1,1-(disappearPercent-1)*2));

if (flash != 0)
{
	shader_set(shFlash);
	shader_set_uniform_f(global.uFlashPercent,flash);
	shader_set_uniform_f_array(global.uFlashColor,flashCol);
}

if (teleportAppear) {
	_rectCol1 = merge_color(_rectCol1,_rectCol2,disappearPercent);	
} else {
	_rectCol1 = merge_color(_rectCol1,_rectCol2,0.25);	
}

// Shooting
if (shootPercent*(1-deadPercent) > 0) {
	surface_set_target(surf);
	draw_clear_alpha(c_black,0);
	draw_sprite_ext(sBossLvl2Eye,0,sprite_width/2,sprite_height/2,eyes[0].obj.image_xscale,eyes[0].obj.image_yscale,eyes[0].obj.image_angle,c_white,1);
	gpu_set_colorwriteenable(1,1,1,0);
	draw_set_color(choose(c_orange, c_red, #ff4400));
	draw_rectangle(0,0,sprite_width,sprite_height,false);
	gpu_set_colorwriteenable(1,1,1,1);
	surface_reset_target();
	draw_set_alpha(shootPercent*(1-deadPercent));
	draw_surface(surf,eyes[0].obj.x-sprite_width/2,eyes[0].obj.y-sprite_height/2-1);
	draw_set_alpha(1);
}

surface_set_target(surf);
draw_clear_alpha(c_black,0);
draw_sprite_part(
	sprite_index,image_index,
	0,max(0,_rectY),
	sprite_width,sprite_height-max(0,_rectY),
	0,max(0,_rectY)
);

if (disappearPercent != 0 or eyeExpandPercent > 0 or deadPercent > 0) {
	gpu_set_colorwriteenable(1,1,1,0);
	draw_set_alpha(max(1-teleportAppear,min(1,eyeExpandPercent*3),deadPercent));
	draw_rectangle_color(
		0,_rectY,
		sprite_width,_rectY+lerp(_rectH,sprite_height+_rectH,min(teleportAppear,1-disappearPercent)),
		_rectCol1,_rectCol1,
		_rectCol2,_rectCol2,
		false
	);
	draw_set_alpha(1);
	gpu_set_colorwriteenable(1,1,1,1);
}
surface_reset_target();

draw_surface(surf,x-sprite_xoffset,y-sprite_yoffset);

if(shader_current() != -1) shader_reset();