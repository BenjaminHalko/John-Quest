/// @desc 

var _y = Wave(-2,2,2,0.8);
var _spriteAngle = (x - xprevious) * -10;
var _yscale = (1 + (y - yprevious) * -0.02) * yscale;
var _mouseDir = item == 2 ? finalSpin : point_direction(x,y,mouse_x,mouse_y);

// Item
var _itemDist = -knockBack*0.5;
var _amount = itemCircleNum*clamp(itemPercent,0,1);
var _cols = [ #7665FF, #65D4FF, #AAC7FE];
if (_amount != itemCircleNum) draw_sprite_ext(sPlayerItemCircle,_amount,xprevious+lengthdir_x(_itemDist,_mouseDir),yprevious+_y+lengthdir_y(_itemDist,_mouseDir),1,1,_mouseDir,_cols[item],0.3);
_itemDist = lerp(-8,14+Wave(-2,2,1.8,1.1)-knockBack*1.4,animcurve_channel_evaluate(itemCurve,min(1,1.5-itemPercent)));
draw_sprite_ext(itemSprites[item],knockBack == 0 ? 0 : 1 + (knockBack % 2),xprevious+lengthdir_x(_itemDist,_mouseDir),yprevious+_y+lengthdir_y(_itemDist,_mouseDir),1,1,_mouseDir,c_white,1);

// Player
_y = Wave(-2,2,2,0)*wavePercent;
draw_sprite_ext(sprite_index,image_index,x,y+_y,1/yscale,_yscale,_spriteAngle,image_blend,image_alpha);
draw_sprite_ext(sPlayerPropeller,propellerIndex,x+lengthdir_x(12*yscale,90+_spriteAngle),y+lengthdir_y(12*yscale,90+_spriteAngle)+_y,1,1/(1-clamp(vsp/movespd,-1,1)*0.6),_spriteAngle,c_white,1);

// Draw Health
for(var i = 0; i < 4; i++) {
	var _xHealth = 4*(i-2)+1;
	var _yHealth = 8*_yscale;
	var _dist = point_distance(0,0,_xHealth,_yHealth);	
	var _dir = point_direction(0,0,_xHealth,_yHealth)+_spriteAngle;
	_xHealth = x+lengthdir_x(_dist,_dir);
	_yHealth = y+_y+lengthdir_y(_dist,_dir);
	
	var _blend = #65FFA9;
	if (i*2 >= hp) _blend = #FF3232;
	else if (i*2+1 >= hp) _blend = #FFDC31;
	 
	
	draw_sprite_ext(sPlayerHealth,0,_xHealth,_yHealth,1,1,_spriteAngle,_blend,1);
}