/// @desc 

healthDisplay = ApproachFade(healthDisplay, oBossLvl1.hp/oBossLvl1.maxHp, 0.02, 0.7);
if (oBossLvl1.dead and oBossLvl1.movement == 0) instance_destroy();