/// @desc 

// Inherit the parent event
event_inherited();

wait = 0;
waitDuration = 60;
wanderDistance = 512;
xTo = x;
yTo = y;
hSpeed = 0;
vSpeed = 0;
moveSpd = 0.8;
timePassed = 0;

count = 0;

places = [
	[xstart,ystart],
	[2224,3064],
	[2552,3296],
	[2816,3072],
	[2056,3288]
];

currentPlace = 0;
xstart = places[currentPlace][0];
ystart = places[currentPlace][1];