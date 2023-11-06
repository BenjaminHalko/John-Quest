var _objects = [pHurt, oSpring];
var _list = ds_list_create();
var _amount = instance_place_list(x+1,y,_objects,_list,false);
_amount += instance_place_list(x-1,y,_objects,_list,false);
_amount += instance_place_list(x,y+1,_objects,_list,false);
_amount += instance_place_list(x,y-1,_objects,_list,false);

attachedObjects = [];

for(var i = 0; i < _amount; i++) {
	array_push(attachedObjects, _list[| i]);
}

ds_list_destroy(_list);

timer = 0;

percent = 0;