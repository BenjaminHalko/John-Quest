/// @desc 

// Draw Image
var _img = global.nodes[global.currentNode].image[global.currentDir];

// Draw Transition
if (global.movePercent != 1) {
	var _nextImg = global.nodes[nextNode].image[nextDir];
	if (turnDir == 0) {
		draw_sprite_ext(sLvl3Images,_img,-248*global.movePercent,-144*global.movePercent,1+global.movePercent,1+global.movePercent,0,c_white,1);
		draw_sprite_ext(sLvl3Images,_nextImg,248*(1-global.movePercent),144*(1-global.movePercent),global.movePercent,global.movePercent,0,c_white,1);
	} else {
		var _xstart = -496 * clamp(turnDir,-1,1);
		var _x = _xstart * (1-global.movePercent);
		draw_sprite(sLvl3Images,_img,_x - _xstart,0);
		draw_sprite(sLvl3Images,_nextImg,_x,0);
	}
} else {
	draw_sprite(sLvl3Images,_img,0,0);
}