x1 = RESOLUTION_W/2;
y1 = RESOLUTION_H-60;
x2 = RESOLUTION_W/2;
y2 = RESOLUTION_H;

x1Target = 80;
x2Target = RESOLUTION_W-80;

textProgress = 0;

responseSelected = 0;
lastTextIndex = -1;

portraits = [
	sSwordNPCPortrait,
	sBombNPCPortrait
];

portraitAnim = [];
for(var i = 0; i < array_length(portraits); i++) {
	array_push(portraitAnim, {
		spd: sprite_get_speed(portraits[i]) / 60,
		number: sprite_get_number(portraits[i]),
	})
}
frameNumber = 0;

talkSound = [
	snSignTalk,
	snSwordTalk,
	snBombTalk,
];