/// @desc 

// Inherit the parent event
event_inherited();

if (global.playerHealth == global.playerHealthMax) {
	instance_change(oCoin,true);
}