/// @desc 

enableLive;

if (audio_is_playing(snBossLvl1Roar)) {
	setCursor(CURSOR.NORMAL);
	ScreenShake(3,5);
	global.allowInput = false;
}

if (global.movePercent != 1) {
	setCursor(CURSOR.NORMAL);
	global.allowInput = false;
	global.movePercent = ApproachFade(global.movePercent,1,0.045+(1-max(0,abs(turnDir)-1,forceSlowTurn*0.5))*0.14,0.6);
	if (global.movePercent == 1) {
		turnDir = 0;
		forceSlowTurn = false;
		if (nextDir != global.currentDir) {
			global.currentDir = nextDir;
			Save("lvl3","dir",global.currentDir);
		} else {
			global.currentNode = nextNode;
			Save("lvl3","node",global.currentNode);

			// Check for boss roar and node
			var _node = global.nodes[global.currentNode];
		
			if (_node.hasPiece != -1 and !global.piecesCollected[_node.hasPiece]) {
				if (_node.pieceDir != global.currentDir) {
					turnDir = 0;
					nextDir = global.currentDir;
					while(nextDir != _node.pieceDir) {
						turnDir++;
						nextDir = Wrap(nextDir+1,0,3);
					}
					turnDir = ((turnDir+1) % 4) - 1;
					global.movePercent = 0;
					forceSlowTurn = true;
				}
			} else {
				for(var i = 0; i < 4; i++) {
					if (_node.nextNode[i] != -1) {
						var _nextNode = global.nodes[_node.nextNode[i]];
						if (_nextNode.hasPiece != -1) {
							var _piece = _nextNode.hasPiece;
							if (!global.piecesCollected[_piece] and !bossRoared[_piece]) {
								audio_play_sound(snBossLvl1Roar,1,false,0.6);
								audio_stop_sound(music);
								onlyAllowUp = true;
								bossRoared[_piece] = true;
							
								if (i != global.currentDir) {
									turnDir = 0;
									while(nextDir != i) {
										turnDir++;
										nextDir = Wrap(nextDir+1,0,3);
									}
									turnDir = ((turnDir+1) % 4) - 1;
									forceSlowTurn = true;
									global.movePercent = 0;
								}
							}
						}
					}
				}
			}
		}
		
		var _node = global.nodes[global.currentNode];
		if (_node.hasPiece != -1 and !global.piecesCollected[_node.hasPiece] and _node.pieceDir == global.currentDir) {
			global.isBattle = true;
			instance_create_layer(0,0,"Boss",oBossLvl3);
			if (!audio_is_playing(mLvl3MusicBoss)) {
				audio_stop_sound(music);
				music = audio_play_sound(mLvl3MusicBoss,1,true);	
			}
		}
	}
} else if (!audio_is_playing(snBossLvl1Roar) and global.inHand == -1 and !audio_is_playing(oInventory.talking) and !global.isBattle) {
	if (onlyAllowUp and !audio_is_playing(mLvl3MusicBoss)) {
		audio_stop_sound(music);
		music = audio_play_sound(mLvl3MusicBoss,1,true);	
	}
	global.allowInput = true;
	
	if (global.my <= INVENTORY_Y) {
		// Vars
		var _node = global.nodes[global.currentNode];
		var _move = false;
		var _rotate = 0;

		// Inventory
		if (_node.nextNode[global.currentDir] != -1) {
			var _amount = 480/4; 
			if (_node.twoWay) _amount -= _amount/3;	
		
			if (onlyAllowUp) {
				setCursor(CURSOR.FORWARD);
				if (global.clicked) {
					onlyAllowUp = false;
					_move = true;
				}
			} else if (global.mx > _amount and global.mx < 480-_amount) {
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
			if (_node.twoWay) setCursor(_left ? CURSOR.BACKWARD_LEFT : CURSOR.BACKWARD_RIGHT);
			else setCursor(_left ? CURSOR.LEFT : CURSOR.RIGHT);
			if (global.clicked) _rotate = _left ? 1 : -1;
		}

		// Move
		if (_move) {
			nextNode = _node.nextNode[global.currentDir];
			global.movePercent = 0;
			audio_play_sound(snWalking,1,false,1,0,random_range(0.8,1.2));
		} else if(_rotate != 0) {
			if (_node.twoWay) audio_play_sound(snWalkingSlow,1,false,1,0,random_range(0.8,1.5));
			else audio_play_sound(snWalking,1,false,1,0,random_range(0.8,1.2));
			nextDir = global.currentDir;
			do {
				nextDir = Wrap(nextDir+_rotate,0,3);
				turnDir += _rotate;
			} until (_node.image[nextDir] != -2);
			global.movePercent = 0;
		}
	}
}