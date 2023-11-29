/// @desc 

enableLive;

for(var i = 0; i < 5; i++) {
	var _x = 480/2+(width - 32)/4*(i-2);
	var _y = 1-animcurve_channel_evaluate(inventoryYCurve,inventoryItemY[i]);
	
	draw_sprite_ext(sInventoryBack,i,_x+8,inventoryY + _y * 96+Wave(-5,0,5,waveOffsets[i]-0.2)+8,1,1,0,c_black,0.5);
	draw_sprite(sInventoryBack,i,_x,inventoryY + _y * 96+Wave(-5,0,5,waveOffsets[i]-0.2));
	if (inventory[i] != -1) {
		if (global.inHand != i and itemReturn != i) {
			draw_sprite(sInventoryItems,i,_x,inventoryY-16+Wave(-5,0,5,waveOffsets[i])+_y*64);
		}
	}
}

if (global.inHand != -1) {
	draw_sprite(sInventoryItems,global.inHand,global.mx,global.my);
} else if (itemReturn != -1) {
	var _x = 480/2+(width - 32)/4*(itemReturn-2);
	var _y = 1-animcurve_channel_evaluate(inventoryYCurve,inventoryItemY[itemReturn]);
	draw_sprite(sInventoryItems,itemReturn,lerp(itemX,_x,itemReturnPercent),lerp(itemY,inventoryY-16+Wave(-5,0,5,waveOffsets[itemReturn]),itemReturnPercent)+_y*64);
}