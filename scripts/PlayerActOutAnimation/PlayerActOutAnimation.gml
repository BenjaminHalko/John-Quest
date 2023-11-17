///@desc PlayerActOutAnimation(Sprite, EndScript)
///@arg Sprite
///@arg EndScript
function PlayerActOutAnimation() {
	state = PlayerStateAct;
	animType = argument[0];
	if(argument_count > 1) animationEndScript = argument[1];
}
