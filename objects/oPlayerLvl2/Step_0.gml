/// @desc 

Input();

inputMagnitude = (keyRight - keyLeft != 0) or (keyDown - keyUp != 0);
inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);

state();
invulnerable = max(invulnerable-1,0);
flash = max(flash-0.05,0);

depth = -bbox_bottom;