function CreateAfterImage(_obj, _spd=0.1) {
	with(instance_create_depth(_obj.x,_obj.y,depth+1,oAfterImage)) {
		image_xscale = _obj.image_xscale;
		image_yscale = _obj.image_yscale;
		image_angle = _obj.image_angle;
		sprite_index = _obj.sprite_index;
		image_index = _obj.image_index;
		image_speed = 0;
		spd = _spd; 
	}
}