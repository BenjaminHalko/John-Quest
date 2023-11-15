var _objects = [oSpike, oSpring];
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

// Create springs
if (array_length(attachedObjects) == 0) {
	for(var i = bbox_left; i < bbox_right; i += 16) {
		if (!position_meeting(i+8,bbox_top-8,_objects)) {
			array_push(attachedObjects, instance_create_layer(i,bbox_top-16,"Springs",oSpring));
		}
	}
}

timer = 0;

percent = 0;

// Resize
if (position_meeting(bbox_left-1,bbox_bottom-8,_objects) || position_meeting(bbox_right+1,bbox_bottom-8,_objects)) {
	image_yscale += 6/16;	
}