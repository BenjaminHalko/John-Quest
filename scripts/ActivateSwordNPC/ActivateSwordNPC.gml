function ActivateSwordNPC()
{
	
	function RemoveHat() {
		global.questStatusHat = 2;
		Save("lvl2","questHat",global.questStatusHat);
		PlayerDropItem();
		instance_destroy(oHat);
	}
	
	var _hasHat = (global.iLifted != noone) and (global.iLifted.object_index == oHat);
	switch (global.questStatusHat)
	{
		case 0: case 0.5://not started
		{
			//player might have brought the hat back anyway
			if(_hasHat)
			{
				//complete quest
				RemoveHat();
				NewTextBox("Wow, you found my hat without\nme even asking you to!",1);
				NewTextBox("You are a true hero indeed!",1);
				NewTextBox("Here, take this sword.\nI hear it is dangerous to go without it.",1);
				oPlayer.lastState = PlayerStateGetItem;
			}
			else
			{
				//offer quest
				if (global.questStatusHat == 0) {
					NewTextBox("Hello there! You look like a brave adventurer.",1);
					NewTextBox("Could you help me find my missing hat?",1,["0:Of course!","1:This task is beneath me"]);
				} else {
					NewTextBox("Did you change your mind about helping me?",1,["0:Sure, I can help.","1:Haha! I don't care about your stinky hat!"]);
				}
				
			}
		}break;
		case 1: //quest in progress
		{
			if(_hasHat)
			{
				//complete quest
				RemoveHat();
				NewTextBox("Wow, you found my hat!",1);
				NewTextBox("You are a true hero indeed!",1);
				NewTextBox("Here, take this sword.\nI hear it is dangerous to go without it.",1);
				oPlayer.lastState = PlayerStateGetItem;
			}
			else
			{
				//clue reminder
				NewTextBox("Did you forget where I left my hat?\nI think it was in the Evil Slime Base.",1);
			}
		}break;
		case 2: //quest already completed
		{
			if (!global.playerItemUnlocked[ITEM.SWORD]) {
				NewTextBox("Here, take this sword.\nI hear it dangerous to go without it.",1);
				oPlayer.lastState = PlayerStateGetItem;
			} else {
				NewTextBox("I am glad I got my hat back,\nnow I can see again.",1);
			}
		}break;
	}
}

function ActivateSwordNPCItemGot() {
	NewTextBox("Thanks again!\nI hope you find that sword useful!",1);
}