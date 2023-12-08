/// @desc 

percent = ApproachFade(percent, (oBossLvl4Phase1.explosionCount < 8), 0.1, 0.6);
healthDisplay = ApproachFade(healthDisplay, oBossLvl4Phase1.hp/oBossLvl4Phase1.maxHp, 0.02, 0.7);
if (percent == 0) instance_destroy();