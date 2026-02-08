/// @desc 

enum MENU {
	MAIN,
	LEVELSELECT,
    OPTIONS,
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

locales = lexicon_languages_get_array();

loadMenuText = function() {
    mainMenu = [
    	lastLevel == -1 ? lexicon_text("menu.newgame") : lexicon_text("menu.continue"),
    	lexicon_text("menu.worldselect"),
    	lexicon_text("menu.options"),
    	lexicon_text("menu.credits"),
    ];
    
    if (os_type != os_operagx)
        array_push(mainMenu, lexicon_text("menu.quit"));
    
    var _world = lexicon_text("menu.world");
    var _boss = lexicon_text("menu.boss");
    levelSelect = [
    	lexicon_text("menu.back"),
    	$"{_world} 0", $"{_boss} 0",
    	$"{_world} 1", $"{_boss} 1",
    	$"{_world} 2", $"{_world} 3",
    	$"{_boss} 3", $"{_boss} ?",
    ];
    
    options = [
        lexicon_text("menu.back"),
        lexicon_text("menu.language"),
        lexicon_text("menu.audio")
    ];
    
    langIndex = lexicon_language_get_index();
    currentLang = lexicon_language_get();
}

loadMenuText();

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
    lexicon_text("intro0"),
    lexicon_text("intro1"),
    lexicon_text("intro2"),
    lexicon_text("intro3"),
    lexicon_text("intro4")
];

startUpPos = 0;
music = -1;
musicLength = audio_sound_length(mOpening)-0.5;
moveUpCurve = animcurve_get_channel(TitleCurves,"moveUp");
blend = 0;