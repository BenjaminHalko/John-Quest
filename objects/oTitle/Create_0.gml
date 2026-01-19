/// @desc 

global.noSave = false;

enum MENU {
	MAIN,
	LEVELSELECT,
	CREDITS
}

title = false;

moveUpPercent = 0;
moveUpSpd = 0;

lastLevel = Load("global","lvl",-1);

menuSelected = 0;

textNum = -1;
textTarget = -1;
textAlpha = 1;
wait = 0;

smallerBuildingHeight = sprite_get_height(sTitleLandscape);
buildingHeight = sprite_get_height(sTitleBuilding);
buildingScale = 24 * 144 / buildingHeight;

blink = 0;
blinkSpd = 5;
blinkWave = 0;

allowInput = true;

menu = MENU.MAIN;

stars = [];

mainMenu = [
	lastLevel == -1 ? "NEW GAME" : "CONTINUE",
	"WORLD SELECT",
	"CREDITS",
    "QUIT",
];

levelSelect = [
	"BACK",
	"WORLD 0", "BOSS 0",
	"WORLD 1", "BOSS 1",
	"WORLD 2", "WORLD 3",
	"BOSS 3", "BOSS ?",
];

repeat(100) {
	array_push(stars, {
		x: irandom(480),
		y: irandom(500),
		alpha: random(1),
		spd: random_range(0.001,0.01),
		paralax: random_range(1,1.5),
		col: choose(c_white, c_aqua, c_yellow, c_fuchsia)
	})	
}

text = [
"IN THE MYSTICAL REALMS,\nA TALE OF TWO RIVALS UNFOLDED.",
"JOHN, THE WARRIOR OF LIGHT,\nAND EVIL JOHN, HIS SHADOW TWIN.",
"EVIL JOHN, CONSUMED BY ENVY,\nSOUGHT TO CONQUER BOTH REALMS.",
"WITH HIS SIX EVIL EYES, HE CORRUPTED\nTHE INHABITANTS OF THE LAND.",
"JOHN, WITH HIS EXPERTISE IN GAMING,\nMUST RESTORE PEACE TO THE WORLD."
];

startUpPos = 0;
music = -1;
musicLength = audio_sound_length(mOpening)-0.5;
moveUpCurve = animcurve_get_channel(TitleCurves,"moveUp");
blend = 0;