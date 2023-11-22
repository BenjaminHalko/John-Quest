/// @desc 

if (place_meeting(x,y,oPlayer)) {
	var _destroy = true;
	for(var i = 0; i < array_length(enemies); i++) {
		if (instance_exists(enemies[i])) {
			_destroy = false;
			break;
		}
	}
	
	if (_destroy) {
		var _list = ds_list_create();
		var _amount = instance_place_list(x,y,oRockPile,_list,false);
		
		for(var i = 0; i < _amount; i++) {
			with(_list[| i]) {
				call_later(10 + (i * 5), time_source_units_frames, function() {
					instance_create_depth(x,y,depth,oExplode);
					instance_destroy()
				});
			}
		}
		
		ds_list_destroy(_list);
		
		instance_destroy();
	}
}