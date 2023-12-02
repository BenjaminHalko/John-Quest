/// @desc 

#region Create Node List
global.nodes = [
	// Outside
	new Node(-2,-3,-2,1), // 1st piece
	new Node(-1,0,2,-1),
	new Node(1,-1,-1,3),
	new Node(-1,2,4,-1),
	new Node(3,5,-1,-1),
	new Node(-2,6,-2,4),
	new Node(-1,-1,7,5),
	new Node(6,8,-1,-1),
	new Node(-2,9,-2,7),
	new Node(-2,10,-2,8),
	
	// Lobby F1 - 10
	new Node(-1,11,30,9),
	new Node(13,31,12,10),
	new Node(11,15,-1,-1),
	new Node(-1,14,11,-1),
	new Node(-1,-1,15,13),
	new Node(14,-1,16,12),
	
	// Corridor F1 - 16
	new Node(15,-2,17,-2),
	new Node(16,18,-1,-1), // Turn
	new Node(-2,19,-2,17),
	new Node(-1,-1,20,18), // Turn
	new Node(19,-2,21,-2),
	new Node(20,-1,-1,22), // Turn
	new Node(-2,21,-2,23),
	new Node(-2,22,-2,24),
	new Node(-2,23,-2,25),
	new Node(-1,24,26,27), // Split
	new Node(25,-4,-1,-1), // 2nd piece
	new Node(28,25,-1,-1), // Turn
	new Node(29,-2,27,-2),
	new Node(30,-2,28,-2),
	new Node(10,-2,29,-2),
	
	// Lobby F2 - 31
	new Node(-2,32,-2,11),
	new Node(-1,-1,33,31),
	new Node(32,34,-1,35),
	new Node(-1,-1,49,33),
	new Node(-2,33,-2,36),
	new Node(-1,35,37,-1),
	
	// Corridor F2 - 37
	new Node(36,-2,38,-2),
	new Node(37,-2,39,-2),
	new Node(38,-2,40,-2),
	new Node(39,41,-1,-1), // Turn
	new Node(-2,42,-2,40),
	new Node(-2,43,-2,41),
	new Node(44,-1,-1,42), // Turn
	new Node(46,-1,43,45), // Split
	new Node(-2,44,-2,-5), // 3rd piece
	new Node(47,-2,44,-2),
	new Node(-1,-1,46,48), // Turn
	new Node(49,47,-1,-1), // Turn
	new Node(34,-2,48,-2)
];
#endregion

// Assign images
var _imageIndex = 0;
for(var i = 0; i < array_length(global.nodes); i++) {
	for(var j = 0; j < 4; j++) {
		if (global.nodes[i].image[j] != -2) {
			global.nodes[i].image[j] = _imageIndex;
			_imageIndex++;
		}
	}
}

// Load
global.currentNode = Load("lvl3","node",10);
global.currentDir = Load("lvl3","dir",1);
global.piecesCollected = [
	Load("lvl3","item0",false),
	Load("lvl3","item1",false),
	Load("lvl3","item2",false),
];

nextNode = global.currentNode;
nextDir = global.currentDir;
turnDir = 0;
forceSlowTurn = false;
onlyAllowUp = false;
global.movePercent = 1;

// Roar
bossRoared = array_create(3,false);

// Input
global.allowInput = true;

// Is battle
global.isBattle = false;

var _node = global.nodes[global.currentNode];
if (_node.hasPiece != -1 and !global.piecesCollected[_node.hasPiece] and _node.pieceDir == global.currentDir) {
	global.isBattle = true;	
	instance_create_layer(0,0,"Boss",oBossLvl3);
}

if (global.isBattle) {
	music = audio_play_sound(mLvl3MusicBoss,1,true);
} else {
	var _music = [mLvl3Music,mLvl3Music2,mLvl3Music3];
	var _amount = 0;
	for(var i = 0; i < 3; i++) {
		_amount += global.piecesCollected[i];	
	}
	music = audio_play_sound(_music[min(2,_amount)],1,true);
}