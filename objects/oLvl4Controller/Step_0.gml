/// @desc 

// Cursors
if (windowWidth != window_get_width() or windowHeight != window_get_height()) {
	windowWidth = window_get_width();
	windowHeight = window_get_height();
	createCursors();
}

// Hide cursor if gamepad
if (InputPlayerUsingGamepad()) {
    if (global.currentCursorType == CURSOR.LVL4)
        setCursor(-1);
} else if (global.currentCursorType == -1) {
    setCursor(CURSOR.LVL4);
}

// Backgrounds
for(var i = 0; i < array_length(bgElements); i++) {
	var _x = bgElements[i].x + (oCamera.x - bgElements[i].x) * bgElements[i].depth / 100;
	var _y = bgElements[i].y + (oCamera.y - bgElements[i].y) * bgElements[i].depth / 100;
	if (bgElements[i].isBG) {
		layer_x(bgElements[i].element, _x);
		layer_y(bgElements[i].element, _y+816);
	} else {
		layer_sprite_x(bgElements[i].element, _x);
		layer_sprite_y(bgElements[i].element, _y);
	}
}

// Collision
instance_deactivate_object(pCollision);
instance_deactivate_object(oRockLvl4);

instance_activate_region(oCamera.x-400,oCamera.y-400,480+800,270+800,true);
if (instance_exists(oCamera.boundary)) {
	instance_activate_region(oCamera.boundary.x-200,oCamera.boundary.y-200,oCamera.boundary.sprite_width+400,oCamera.boundary.sprite_height+400,true);
}