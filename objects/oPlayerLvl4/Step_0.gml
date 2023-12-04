/// @desc 

enableLive;

Input()
var _moveX = keyRight-keyLeft;
var _moveY = keyDown - keyUp;
var _fire = mouse_check_button(mb_left);

hsp = ApproachFade(hsp,_moveX*movespd,0.8,0.85);
vsp = ApproachFade(vsp,_moveY*movespd,0.8,0.85);

x += hsp;
y += vsp;


// shooting
if (_fire) {
	if (--shotTimer <= 0) {
		with(instance_create_depth(x+random_range(-6,6),y+random_range(-6,6),depth-1,oPlayerBulletsLvl4)) {
			direction = point_direction(x,y,mouse_x,mouse_y);
			image_angle = direction;
		}
		ScreenShake(2,2);
		shotTimer = 5;
	}
} else {
	shotTimer = 0;
}

// animation
propellerIndex = (propellerIndex + propellerSpd) % propellerNum;
image_angle = hsp * -10;
image_yscale = 1 + vsp * -0.02;