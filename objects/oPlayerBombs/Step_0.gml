/// @desc 

enableLive;

vSpd += grv;
image_angle -= 2 * hSpd;

var _collide = [global.collisionMap];

if (array_length(MoveAndCollide(hSpd,vSpd,0,0)) > 0 or place_meeting(x,y,_collide)) {
	repeat(100) {
		with(instance_create_depth(x,y,depth-1,oTriangleParticle)) {
			image_blend = merge_color(c_ltgray,c_dkgray,random(1));
			direction = random(360);
			image_angle = random(360);
			speed = random(3);
			spd = random_range(0.03,0.06);
			radius = 6;
		}
	}
	ScreenShake(5,5);
	instance_destroy();
}