/// @desc 

// Inherit the parent event
event_inherited();

if (global.playerHealth == global.playerHealthMax and !forceHeart) {
	instance_change(oCoin,true);
}