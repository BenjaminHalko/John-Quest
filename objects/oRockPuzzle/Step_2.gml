// Inherit the parent event
event_inherited();

if (thrown and !inRightSpot and !entityThrowBreak) {
    var _dist = point_distance(xstart, ystart, targetSpotX, targetSpotY);
    var _dir = point_direction(xstart, ystart, targetSpotX, targetSpotY);
    if (_dist < 90 and angle_difference(_dir, direction) < 90) {
        entityThrowDistance = _dist;
        direction = _dir
        inRightSpot = true;
    }
}

if (!thrown and inRightSpot) {
    inRightSpot = false;
    entityThrowDistance = 52;
    entityThrowBreak = true;
    if (STEAM_ENABLED) {
        steam_set_achievement("world2_secretsign");
    }
    
    NewTextBox("Ya ha ha!", 0);
}