/// @desc 

if (global.playerItemUnlocked[ITEM.BOMB] and !place_meeting(x,y,oEnemyArena)) {
	instance_destroy();
	exit;
}

var _list = ds_list_create();
var _amount = instance_place_list(x,y,oRockPile,_list,false);

rocks = [];

for(var i = 0; i < _amount; i++) {
	instance_deactivate_object(_list[| i]);
	array_push(rocks, _list[| i]);
}
ds_list_destroy(_list);

activated = false;