/// @desc 

inputMagnitude = InputDistance(INPUT_CLUSTER.NAVIGATION);
inputDirection = InputDirection(0, INPUT_CLUSTER.NAVIGATION);

state();
invulnerable = max(invulnerable-1,0);
flash = max(flash-0.05,0);

if (changeDepth) depth = -bbox_bottom;