/// @desc

var _camX = camera_get_view_x(view_camera[0]);
var _camY = camera_get_view_y(view_camera[0]);

draw_set_color(c_black);
switch(transitionType) {
	case TRANSITION.SQUARES: {
		var _delay = 2;
		for(var i = 0; i < 16; i++) {
			for(var j = 0; j < 9; j++) {
				var _dir = leading ? (1 - j / 9) : (j / 9);
				var _percent = clamp(percent * (1 + _delay) - _dir * _delay, 0, 1);
				if (_percent > 0) {
					var _x = _camX + (i + 0.5) * 30;
					var _y = _camY + (j + 0.5) * 30;
					var _size = 30 * _percent;
					draw_rectangle(_x - _size / 2, _y - _size / 2, _x + _size / 2, _y + _size / 2, false);
				}
			}
		}
	} break;
	case TRANSITION.SPIRAL: {
		var _heightLeft = 270;
		var _widthLeft = 480 - size;
		var _x = _camX;
		var _y = _camY;
		var _dir = 270;
		var _distanceLeft = distance;
		var i = 0;
		while(_distanceLeft > 0 and (_widthLeft > 0 or _heightLeft > 0)) {
			var _targetLength = (_dir % 180 == 0) ? _widthLeft : _heightLeft;
			var _percentLength = clamp(distance * percent * 1.05 - (distance - _distanceLeft), 0,  _targetLength);
			
			var _drawX = _x;
			var _drawY = _y;
			if (_dir % 360 == 90) {
				_drawY -= _percentLength;
			} else if (_dir % 360 == 180) {
				_drawX -= _percentLength;	
			}
			
			if (_dir % 180 == 0) {
				if (_percentLength > 0) draw_rectangle(_drawX,_drawY,_drawX+_percentLength,_drawY+size,false);
				
				_x += lengthdir_x(_widthLeft-size*(_dir % 360 == 0), _dir);
				_distanceLeft -= _widthLeft;
				_widthLeft -= size;
				
			} else {
				if (_percentLength > 0) draw_rectangle(_drawX,_drawY,_drawX+size,_drawY+_percentLength,false);
				
				_y += lengthdir_y(_heightLeft-size*(_dir % 360 == 270), _dir);
				_distanceLeft -= _heightLeft;
				_heightLeft -= size;
				
			}
			
			if (_dir % 360 == 180)  {
				_y += size;	
			} else if (_dir % 360 == 270) {
				_x += size;	
			}
			_dir += 90;
		}
	} break;
	case TRANSITION.FADE: {
		draw_set_alpha(clamp(percent,0,1));
		draw_rectangle(0,0,room_width,room_height,false);
		draw_set_alpha(1);
	} break;
}