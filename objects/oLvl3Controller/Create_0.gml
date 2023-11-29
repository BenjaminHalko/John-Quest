/// @desc 

// Load all texture maps
//texture_prefetch("tgLvl3");

// Cursor
windowWidth = window_get_width();
windowHeight = window_get_height();
global.cursors = [];
global.currentCursorType = 0;
createCursors();