if background == 1 {
	frameNumber = oSwordNPC.image_index;
}
if(background == 2) {
	frameNumber = (frameNumber + 12/60) % 3;
}
if(background == 3) {
	frameNumber = (frameNumber + sprite_get_speed(sBossLvl2Portrait)/60) % sprite_get_number(sBossLvl2Portrait);
}

lerpProgress += (1 - lerpProgress) / 50;
textProgress += global.textSpeed;

if (lastTextIndex != floor(textProgress) and textProgress < string_length(text)) {
	lastTextIndex = floor(textProgress);
	if (string_char_at(text, lastTextIndex) != " ") {
		var _char = max(-26,ord(string_lower(string_char_at(text, lastTextIndex))) - ord("z"));
		audio_play_sound(talkSound[background],1,false,1,0,1-_char*0.01);
	} else {
		audio_stop_sound(talkSound[background]);	
	}
    
    if (background == 3 and STEAM_ENABLED and !instance_exists(oTextQueued) and lastTextIndex >= string_length(text)-ceil(global.textSpeed)) {
        steam_set_achievement("world2_evil");
    }
}

x1 = lerp(x1, x1Target, lerpProgress);
x2 = lerp(x2, x2Target, lerpProgress);

//Cycle Through Responses
responseSelected += InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
var _max = array_length(responses)-1;
var _min = 0;
if (responseSelected > _max) responseSelected = _min;
if (responseSelected < _min) responseSelected = _max;

if (InputPressed(INPUT_VERB.ACCEPT))
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
			global.gamePaused = false;
			with(pEnemy) {
				image_speed = 1;
			}	
			with(oPlayer) {
				state = lastState;
				InputVerbConsume(INPUT_VERB.ACCEPT);
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