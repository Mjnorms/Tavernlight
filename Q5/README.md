Q5 was completed by creating a new spell! 
The setup loops through a table of areas to create a table of combats, and then onSpellCast sets up a bunch of events on a delay to execute those combats.

It does not directly match the original, as the sprite offset of my spritesheet was different. 
I attempted to alter the offset of the sprite using an AssetEditor that I found of the OTLand forums but the tool did not work for me. 
The other option was to edit the functionality of effect.cpp and the xPattern and yPattern inputs to the draw call, but I ended up just having fun with it and creating a similar spell with the same idea.