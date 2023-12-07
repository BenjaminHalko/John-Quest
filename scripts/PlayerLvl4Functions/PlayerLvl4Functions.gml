function MoveAndCollide(_hsp, _vsp,_xoff,_yoff) {
	return move_and_collide(_hsp,_vsp,pCollision,4,_xoff,_yoff);
}

function HurtEnemyLvl4(_obj, _damage, _knockbackX, _knockbackY) {
	with(_obj) {
		hp -= _damage;
		flash = 1;
		if (allowKnockback) {
			knockbackDir = point_direction(0,0,_knockbackX,_knockbackY);
			knockback = point_distance(0,0,_knockbackX,_knockbackY);
		}
	}
}