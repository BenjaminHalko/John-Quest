/// @arg Response
function DialogueResponses(argument0) {

	switch(argument0)
	{
		case 0:
		{
			NewTextBox("Thanks!",1);
			NewTextBox("I think I left it in the evil\nSlime base to the South!",1);
			global.questStatusHat = 1;
			Save("lvl2","questHat",global.questStatusHat);
		}break;
		case 1: {
			NewTextBox(":(",1);
			global.questStatusHat = 0.5;
			Save("lvl2","questHat",global.questStatusHat);
		}
		default: break;
	}


}
