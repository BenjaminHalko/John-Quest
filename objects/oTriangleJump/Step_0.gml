/// @desc 

enableLive;

// Break
breakPercent = Approach(breakPercent, collected, 0.1-0.05*(!collected));
breakCurvePercent = animcurve_channel_evaluate(collected ? disappearCurve : reappearCurve, breakPercent);

// Hover
if (!collected) {
	hoverPercent = Approach(hoverPercent, place_meeting(x,y,oPlayer), 0.1);
} else if (breakPercent == 1) {
	hoverPercent = 0;	
}

// Curve
breakCurvePercent = animcurve_channel_evaluate(collected ? disappearCurve : reappearCurve, breakPercent);
hoverCurvePercent = animcurve_channel_evaluate(hoverCurve, hoverPercent);

// Rotation
outlineRotation += 5 + hoverCurvePercent * 10;