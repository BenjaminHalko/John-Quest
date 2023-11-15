/// @param {Asset.GMRoom} to
function Transition(_to) {
	if (!instance_exists(oTransition)) {
		instance_create_depth(0,0,-10000,oTransition,{roomTo: _to});	
	}
}