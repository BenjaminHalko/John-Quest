/// @param {Asset.GMRoom} to
function Transition(_to, _startPercent=0) {
	if (!instance_exists(oTransition)) {
		instance_create_depth(0,0,-9999999,oTransition,{roomTo: _to, percent: _startPercent});	
	}
}