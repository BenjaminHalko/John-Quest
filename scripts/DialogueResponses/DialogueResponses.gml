/// @arg Response
function DialogueResponses(argument0) {

	switch(argument0)
	{
		case 0:
		{
			NewTextBox("lvl2.sword.getquest.questaccepted0",1);
			NewTextBox("lvl2.sword.getquest.questaccepted1",1);
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
