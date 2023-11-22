/// @desc 



if (Load("lvl2",$"enemyArena{arenaNumber}",false)) {
	var _list = ds_list_create();
	var _amount = instance_place_list(x,y,[oRockPile, oRockTrigger],_list,false);
	for(var i = 0; i < _amount; i++) {
		instance_destroy(_list[| i], false);
	}
	ds_list_destroy(_list);
	instance_destroy();
} else {
	var _list = ds_list_create();
	var _amount = instance_place_list(x,y,pEnemy,_list,false);

	enemies = [];

	for(var i = 0; i < _amount; i++) {
		array_push(enemies, _list[| i]);
	}
	ds_list_destroy(_list);
}