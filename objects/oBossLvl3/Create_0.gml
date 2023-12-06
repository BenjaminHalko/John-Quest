/// @desc 

type = global.nodes[global.currentNode].hasPiece;
instance_create_layer(room_width/2-20,room_height/2-20,layer,oBossLvl3Eye);
instance_create_layer(room_width/2+20,room_height/2-20,layer,oBossLvl3Eye);

showingAnimation = false;