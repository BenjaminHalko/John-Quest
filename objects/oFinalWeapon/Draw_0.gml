/// @desc 

if (draw) draw_self();
else if (oBossLvl4Phase2.dead) {
	draw_sprite_ext(sFinalWeaponLightBeam,0,oPlayer.x-16,oPlayer.y,1.1,1,0,choose(c_white,make_color_hsv(random(360),50,255)),1);
}