lerpProgress += (1 - lerpProgress) / 50;
textProgress += global.textSpeed;

x1 = lerp(x1, x1Target, lerpProgress);
x2 = lerp(x2, x2Target, lerpProgress);

//Cycle Through Responses
keyUp = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
keyDown = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));
responseSelected += (keyDown - keyUp);
var _max = array_length(responses)-1;
var _min = 0;
if (responseSelected > _max) responseSelected = _min;
if (responseSelected < _min) responseSelected = _max;

if (oPlayer.keyAction)
{
	var _textLength = string_length(text);
	if (textProgress >= _textLength)
	{
		if(responses[0] != -1)
		{
			with (originInstance) DialogueResponses(other.responseScripts[other.responseSelected])
		}
		
		instance_destroy();
		if (instance_exists(oTextQueued))
		{
			with (oTextQueued) ticket--;
		}
		else
		{
			with(oPlayer) {
				state = lastState;
				keyAction = false;
			}
		}
	}
	else
	{
		if (textProgress > 2)
		{
			textProgress = _textLength;
		}
	}
}