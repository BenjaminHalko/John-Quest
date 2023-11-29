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
frameNumber = 0;

talkSound = [
	snSignTalk,
	snSwordTalk,
	snBombTalk,
];