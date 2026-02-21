/// @desc 

scrollPercent = 0;
surf = -1;

surfWidth = sprite_get_width(sTitleLandscape);
surfHeight = 132;

// Stars
stars = [];
repeat(100) {
	array_push(stars, {
		x: irandom(480),
		y: irandom(270),
		alpha: random(1),
		spd: random_range(0.001,0.01),
		col: choose(c_white, c_aqua, c_yellow, c_fuchsia)
	})	
}

// Credits
titleOffset = 128;
firstOffset = 64;
headerOffsetAfter = 0;
headerOffset = 48;
sectionOffset = 24;
nameOffset = 16;
finalCreditsOffset = 96;

var _translationCredits = {
    "zh-CN": "HAOXI",
    "pt-BR": "BRUNO MENEGASSI",
    "ja-JP": "ALISSA STAPLES",
    "ru-RU": "ANONYMOUS",
    "zh-TW": "JACK YAU"
};

worldText = lexicon_text("menu.world");

credits = [
	[lexicon_text("credits.createdby"),
	"Benjamin, Haoxi, & Morlan"],
	
	[lexicon_text("credits.programming"),
	"Benjamin"],
	
	[lexicon_text("credits.level"),
	"Benjamin"],
	
	[lexicon_text("credits.music"),
	"Benjamin"],
	
	[0],
	
	[lexicon_text("credits.leveltweaks"),
	"Haoxi & Morlan"],
	
	[lexicon_text("credits.environment"),
	"Benjamin"],
	
	[lexicon_text("credits.boss"),
	"Morlan"],
	
	[1],
	
	[lexicon_text("credits.environment"),
	"Morlan & Haoxi"],
	
	[lexicon_text("credits.character"),
	"Morlan"],
	
	[lexicon_text("credits.keyitem"),
	"Benjamin"],
	
	[lexicon_text("credits.boss"),
	"Morlan"],
    
    [lexicon_text("credits.rpgtemplate"),
    "@SaraJS"],
	
	[2],
	
	[lexicon_text("credits.pictures"),
	"Benjamin"],
	
	[lexicon_text("credits.voice"),
	"John Appleby"],
	
	[lexicon_text("credits.keyitem"),
	"Morlan"],
	
	[lexicon_text("credits.boss"),
	"Morlan"],
	
	[3],
	
	[lexicon_text("credits.environment"),
	"Morlan"],
	
	[lexicon_text("credits.keyitem"),
	"Haoxi & Morlan"],
	
	[lexicon_text("credits.boss"),
	"Benjamin"],
	
	[ $"~ {lexicon_text("credits.title")} ~"],
	
	[lexicon_text("credits.logo"),
	"Benjamin"],
	
	[lexicon_text("credits.environment"),
	"Morlan"],
    
    [lexicon_text("credits.face"),
	"John Appleby"],
    
    [ $"~ {lexicon_text("credits.translations")} ~"],
];

var _langs = lexicon_languages_get_array();
languageFonts = {};
for(var i = 0; i < array_length(_langs); i++) {
    if (!struct_exists(_translationCredits, _langs[i][1])) {
        continue;
    }
    
    var _fontConfig = LexiconGetFont(_langs[i][1]);
    languageFonts[$ _langs[i][0]] = _fontConfig;
    array_push(credits, [_langs[i][0], _translationCredits[$ _langs[i][1]]])
}

array_push(credits,
    [lexicon_text("credits.thanks1")],
    [lexicon_text("credits.thanks2")])

// Calc Height
creditsHeight = sprite_get_height(sTitle)+titleOffset+firstOffset+finalCreditsOffset*2-headerOffsetAfter;

for(var i = 0; i < array_length(credits); i++) {
	if (array_length(credits[i]) == 2) {
		creditsHeight += sectionOffset + nameOffset + (string_count("\n",credits[i][0])*global.fontRPGSpacing);
		credits[i] = [credits[i], sectionOffset];
	} else {
		creditsHeight += headerOffset+headerOffsetAfter;
		credits[i] = [credits[i], headerOffset];
	}
}

startY = 280;
endY = startY-creditsHeight+24;

// Music
musicLen = audio_sound_length(mCredits)-0.3;
music = audio_play_sound(mCredits,1,false);