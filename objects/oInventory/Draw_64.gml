/// @desc 

for(var i = 0; i < inventorySlots; i++) {
	var _x = 480/2 + (width - 32)/(inventorySlots-1)*(i-(inventorySlots-1)/2);
	var _y = 1-animcurve_channel_evaluate(inventoryYCurve,inventoryItemY[i]);
	
	draw_sprite_ext(sInventoryBack,i,_x+8,inventoryY + _y * 96+Wave(-5,0,5,waveOffsets[i]-0.2)+8,1,1,0,c_black,0.5);
	draw_sprite(sInventoryBack,i,_x,inventoryY + _y * 96+Wave(-5,0,5,waveOffsets[i]-0.2));
	if (inventory[i] != -1) {
		if (global.inHand != i and itemReturn != i) {
			var _hovering = (point_in_rectangle(global.mx,global.my,_x-24,inventoryY-48,_x+24,inventoryY)) and (global.inHand == -1);
			if (_hovering) DrawOutline(sInventoryItems,inventory[i],_x,inventoryY-16+Wave(-5,0,5,waveOffsets[i])+_y*64);
			else draw_sprite(sInventoryItems,inventory[i],_x,inventoryY-16+Wave(-5,0,5,waveOffsets[i])+_y*64);
		}
	}
}

if (global.inHand != -1) {
	if (global.inHand != INVENTORY.LIST or global.isBattle) DrawOutline(sInventoryItems,inventory[global.inHand],global.mx,global.my);
	else {
		draw_set_font(fRetro);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(c_black);
		draw_sprite(sList,0,240,INVENTORY_Y/2+16);
		draw_text(236,INVENTORY_Y/2-36,"Required Parts");
		draw_line_width(180,INVENTORY_Y/2-30,290,INVENTORY_Y/2-30,2);
		draw_set_halign(fa_left);
		var _x = 240 - 44;
		for(var i = 0; i < 3; i++) {
			var _y = INVENTORY_Y/2+28+(i-1)*32;
			draw_sprite(sCheckmark,global.piecesCollected[i],_x,_y);
			draw_text_ext(_x+20,_y-1,itemListDesc[i],9,100);
		}
	}
} else if (itemReturn != -1) {
	var _x = 480/2 + (width - 32)/(inventorySlots-1)*(itemReturn-(inventorySlots-1)/2);
	var _y = 1-animcurve_channel_evaluate(inventoryYCurve,inventoryItemY[itemReturn]);
	draw_sprite(sInventoryItems,inventory[itemReturn],lerp(itemX,_x,itemReturnPercent),lerp(itemY,inventoryY-16+Wave(-5,0,5,waveOffsets[itemReturn]),itemReturnPercent)+_y*64);
}

if (audio_is_playing(talking)) {
	var _width = string_width(subtitles);
	var _height = string_height(subtitles);
	var _margin = 6;
	
	draw_set_color(c_black);
	draw_set_font(fRetro);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_alpha(0.6);
	draw_roundrect(240-_width/2-_margin,8-_margin,240+_width/2+_margin/2,8+_height+_margin/2,false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_text(240,8,subtitles);
}