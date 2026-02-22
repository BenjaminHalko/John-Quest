/// @desc Stop Sequence Breaks

// Inherit the parent event
event_inherited();

with (oPlayer) {
    if (x > other.x - 100 and x < other.x + 100 and !global.playerItemUnlocked[ITEM.BOMB]) {
        y = max(y, other.y+2);
    }
}

