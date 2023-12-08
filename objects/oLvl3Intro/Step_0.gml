/// @desc 

if (lvl4) index++;
else index -= 10;
percent = Approach(percent,1,0.005);

if (percent == 1) {
	if (lvl4) {
		Save("lvl4","seenIntro",true);
		global.introLvl3 = 2;
		Transition(rLvl4);
	} else {
		Save("lvl3","seenIntro",true);
		global.introLvl3 = 1;
		Transition(rLvl3);
	}
}