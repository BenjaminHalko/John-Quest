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
				NewTextBox("lvl2.sword.questcomplete.foundhatwithoutasking",1);
				NewTextBox("lvl2.sword.questcomplete.hero",1);
				NewTextBox("lvl2.sword.questcomplete.getsword",1);
				oPlayer.lastState = PlayerStateGetItem;
			}
			else
			{
				//offer quest
				if (global.questStatusHat == 0) {
					NewTextBox("lvl2.sword.getquest.request0",1);
					NewTextBox("lvl2.sword.getquest.request1",1,[ $"0:lvl2.sword.getquest.response.accept","1:lvl2.sword.getquest.response.reject"]);
				} else {
					NewTextBox("lvl2.sword.changedmind.request",1,["0:lvl2.sword.changedmind.accept","1:lvl2.sword.changedmind.reject"]);
				}
				
			}
		}break;
		case 1: //quest in progress
		{
			if(_hasHat)
			{
				//complete quest
				RemoveHat();
				NewTextBox("lvl2.sword.questcomplete.foundhat",1);
				NewTextBox("lvl2.sword.questcomplete.hero",1);
				NewTextBox("lvl2.sword.questcomplete.getsword",1);
				oPlayer.lastState = PlayerStateGetItem;
			}
			else
			{
				//clue reminder
				NewTextBox("lvl2.sword.clue",1);
			}
		}break;
		case 2: //quest already completed
		{
			if (!global.playerItemUnlocked[ITEM.SWORD]) {
				NewTextBox("lvl2.sword.questcomplete.getsword",1);
				oPlayer.lastState = PlayerStateGetItem;
			} else {
				NewTextBox("lvl2.sword.gothat",1);
			}
		}break;
	}
}

function ActivateSwordNPCItemGot() {
	NewTextBox("lvl2.sword.questcomplete.gotsword",1);
}