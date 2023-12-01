/// @desc 

#macro INVENTORY_Y 200

// Cursor
windowWidth = window_get_width();
windowHeight = window_get_height();
global.cursors = [];
global.currentCursorType = 0;
createCursors();