/// @desc 

enableLive;

if (global.movePercent != 1) {
	setCursor(CURSOR.NORMAL);
	global.movePercent = ApproachFade(global.movePercent,1,0.08+(1-max(0,abs(turnDir)-1))*0.2,0.6);
	if (global.movePercent == 1) {
		global.currentNode = nextNode;
		global.currentDir = nextDir;
		turnDir = 0;
	}
} else {
	// Vars
	var _node = global.nodes[global.currentNode];
	var _move = false;
	var _rotate = 0;

	// Inventory
	if (global.my > 220) {
		setCursor(CURSOR.NORMAL);
	} else if (_node.nextNode[global.currentDir] != -1) {
		var _amount = 480/4; 
		if (_node.twoWay) _amount -= _amount/3;	
		
		if (global.mx > _amount and global.mx < 480-_amount) {
			setCursor(CURSOR.FORWARD);
			if (global.clicked) _move = true;
		} else {
			var _left = (global.mx <= _amount);
			if (_node.twoWay) setCursor(_left ? CURSOR.BACKWARD_LEFT : CURSOR.BACKWARD_RIGHT);
			else setCursor(_left ? CURSOR.LEFT : CURSOR.RIGHT);
			if (global.clicked) _rotate = _left ? 1 : -1;
		}
	} else {
		var _left = (global.mx <= 480/2);
		setCursor(_left ? CURSOR.LEFT : CURSOR.RIGHT);
		if (global.clicked) _rotate = _left ? 1 : -1;
	}

	// Move
	if (_move) {
		nextNode = _node.nextNode[global.currentDir];
		global.movePercent = 0;
	} else if(_rotate != 0) {
		nextDir = global.currentDir;
		do {
			nextDir = Wrap(nextDir+_rotate,0,3);
			turnDir += _rotate;
		} until (_node.image[nextDir] != -2);
		global.movePercent = 0;
	}
}