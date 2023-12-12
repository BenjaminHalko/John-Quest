/// @desc 

enableLive;

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
titleOffset = 144;
firstOffset = 64;
headerOffsetAfter = 0;
headerOffset = 48;
sectionOffset = 24;
nameOffset = 16;
logoOffsetBefore = 16;
finalCreditsOffset = 96;

credits = [
	["A game by",
	"Benjamin, Haoxi, & Morlan"],
	
	["Programming",
	"Benjamin"],
	
	["Level design",
	"Benjamin"],
	
	["Music & Sound FX",
	"Benjamin"],
	
	["~ Level 1 ~"],
	
	["Level design\ntweaked & playtested by",
	"Haoxi & Morlan"],
	
	["Environmental art",
	"Benjamin"],
	
	["Boss design",
	"Morlan"],
	
	["~ Level 2 ~"],
	
	["Environmental art",
	"Morlan & Haoxi"],
	
	["Character design",
	"Morlan"],
	
	["Key item design",
	"Benjamin"],
	
	["Boss design",
	"Morlan & Benjamin"],
	
	["Additional player art",
	"Dall-E 2"],
	
	["~ Level 3 ~"],
	
	["Photos",
	"Benjamin"],
	
	["Voice over",
	"Eleven Labs"],
	
	["Key item design",
	"Morlan"],
	
	["Boss design",
	"Morlan"],
	
	["~ Level 4 ~"],
	
	["Environmental art",
	"Morlan"],
	
	["Key item design",
	"Haoxi & Morlan"],
	
	["Boss design",
	"Benjamin"],
	
	["Additional boss art",
	"Dall-E 2"],
	
	["~ Title ~"],
	
	["Logo",
	"Benjamin"],
	
	["Environmental art",
	"Morlan"],
	
	["_gamemaker_"],
	
	["Thanks to everyone\nthat made this game possible"],
	
	["Thank you for\nplaying"],
];

// Calc Height
creditsHeight = sprite_get_height(sTitle)+titleOffset+firstOffset+finalCreditsOffset*2+logoOffsetBefore-headerOffsetAfter;

for(var i = 0; i < array_length(credits); i++) {
	if (array_length(credits[i]) == 2) {
		creditsHeight += sectionOffset + nameOffset + (string_count("\n",credits[i][0])*10);
		credits[i] = [credits[i], sectionOffset];
	} else {
		creditsHeight += headerOffset+headerOffsetAfter;
		credits[i] = [credits[i], headerOffset];
	}
}

startY = 300;
endY = startY-creditsHeight+6;