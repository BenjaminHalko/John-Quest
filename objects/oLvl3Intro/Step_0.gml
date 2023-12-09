/// @desc 

if (lvl4) index++;
else index -= 10;
percent = Approach(percent,1,0.005);

if (percent == 1) {
	if (lvl4) {
		Transition(rLvl4);
	} else {
		Save("lvl3","seenIntro",true);
		global.introLvl3 = true;
		Transition(rLvl3);
	}
}