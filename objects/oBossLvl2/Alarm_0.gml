/// @desc 

enableLive;

if (shootCounter-- == 0) {
	isTeleporting = true;
	shootCounter = 4;
	var _list =ds_list_create();
	var _count = collision_rectangle_list(oCamera.boundary.bbox_left, oCamera.boundary.bbox_top,oCamera.boundary.bbox_right,oCamera.boundary.bbox_bottom,oSlime,false,true,_list,false);
	ds_list_destroy(_list);
	if (_count <= 2 and enemyHP / maxHp < 0.8) {
		repeat(3) {
			with(instance_create_layer(x,y,"Instances",oSlime)) {
				z = 200;
				grav = 0.1;
				do {
					x = random_range(oCamera.boundary.bbox_left+16,oCamera.boundary.bbox_right-16);
					y = random_range(oCamera.boundary.bbox_top+16,oCamera.boundary.bbox_bottom-16);
				} until(!place_meeting(x,y,global.collisionMap));
			}
		}	
	}
} else {
	isShooting = true;
}