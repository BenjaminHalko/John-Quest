/// @desc 

flash = 0;
if (image_index == 1) exit;

timer = 0;
extra = instance_create_layer(x,y,layer,oCrusher,{image_index: 1});
extra.beatOffset = beatOffset;
extra.beatLoop = beatLoop;
extra.length = length;
extra.distance = distance;
extra.image_yscale = image_yscale - 0.5 * sign(image_yscale);

y += sprite_height - 80 * sign(image_yscale);
image_yscale = sign(image_yscale);
ystart = y;