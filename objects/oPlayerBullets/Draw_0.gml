/// @desc 

if (!helix) {
	draw_self();
} else {
	draw_set_color(image_blend);
	if (helixRectHeight != 0) draw_rectangle(xstart,ystart-helixRectHeight/2,oCamera.x+oCamera.viewWidthHalf,ystart+helixRectHeight/2,false);	

	for(var i = 0; i < array_length(helixDots); i++) {
		draw_circle(helixDots[i].x,y+helixDots[i].y*16,helixDots[i].size*8,false);
		draw_circle(helixDots[i].x,y-helixDots[i].y*16,helixDots[i].size*8,false);	
	}
}