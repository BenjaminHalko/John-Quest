/// @desc 

healthDisplay = ApproachFade(healthDisplay, oLvl1Boss.hp/oLvl1Boss.maxHp, 0.02, 0.7);
if (oLvl1Boss.dead and oLvl1Boss.movement == 0) instance_destroy();