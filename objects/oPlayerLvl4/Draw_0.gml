/// @desc 

enableLive;

var _y = Wave(-2,2,2,0.8);
var _spriteAngle = (x - xprevious) * -10;
var _yscale = 1 + (y - yprevious) * -0.02;
var _mouseDir = point_direction(x,y,mouse_x,mouse_y);

// Item
var _itemDist = -knockBack*0.5;
var _amount = itemCircleNum*clamp(itemPercent,0,1);
var _cols = [ #65FFA9, #65D4FF];
if (_amount != itemCircleNum) draw_sprite_ext(sPlayerItemCircle,_amount,xprevious+lengthdir_x(_itemDist,_mouseDir),yprevious+_y+lengthdir_y(_itemDist,_mouseDir),1,1,_mouseDir,_cols[item],0.3);
_itemDist = lerp(-8,14+Wave(-2,2,1.8,1.1)-knockBack*1.4,animcurve_channel_evaluate(itemCurve,min(1,1.5-itemPercent)));
draw_sprite_ext(itemSprites[item],knockBack == 0 ? 0 : 1 + (knockBack % 2),xprevious+lengthdir_x(_itemDist,_mouseDir),yprevious+_y+lengthdir_y(_itemDist,_mouseDir),1,1,_mouseDir,c_white,1);

// Player
_y = Wave(-2,2,2,0);
draw_sprite_ext(sprite_index,image_index,x,y+_y,image_xscale,_yscale,_spriteAngle,image_blend,image_alpha);
draw_sprite_ext(sPlayerPropeller,propellerIndex,x+lengthdir_x(12,90+_spriteAngle),y+lengthdir_y(12,90+_spriteAngle)+_y,1,1/(1-vsp/movespd*0.6),_spriteAngle,c_white,1);


