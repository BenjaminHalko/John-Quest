/// @desc 

// Cursor
windowWidth = window_get_width();
windowHeight = window_get_height();
global.cursors = [];
global.currentCursorType = CURSOR.LVL4;
createCursors();

// Save
Save("global","lvl",3);