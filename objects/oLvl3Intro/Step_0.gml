/// @desc 

rotation -= 10;
percent = Approach(percent,1,0.005);

if (percent == 1) {
	Save("lvl3","seenIntro",true);
	global.introLvl3 = true;
	Transition(rLvl3);
}