/// @desc 

if (introPhase == -1) exit;
if (sprite_index == sBossLvl1Intro) draw_self();
else DrawBossLvl1(surf);
if (showMovementTutorial and !intro) draw_sprite_ext(sBossLvl1MovementTutorial, 0, oPlayer.x, oPlayer.y,tutorialScale,tutorialScale,0,c_white,1);