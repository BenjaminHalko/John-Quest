state = PlayerStateFree;
hitByAttack = -1;
lastState = state;

inputDirection = 0;
inputMagnitude = 0;

hSpeed = 0;
vSpeed = 0;
speedWalk = 2.5;
speedHook = 3.0;

distanceHook = 88;

animType = PLAYERANIM.IDLE;

z = 0;
invulnerable = 0;
flash = 0;
flashShader = shFlash;
animationEndScript = -1;
animationEnd = false;

hook = 0;
hookX = 0;
hookY = 0;
hookSize = 23//sprite_get_width(sHookChain);

// custom
lastAnim = animType;
animTimer = 0;
walkWave = 0;
topShift = 0;
xDir = 0;
xscale = 1;
yscale = 1;
wHalf = sprite_width/2;