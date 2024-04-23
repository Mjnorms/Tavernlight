# Frigo  
Q5 was completed by creating a new spell!  
The setup loops through a table of areas to create a table of combats, and then onSpellCast sets up a bunch of events on a delay to execute those combats.  

https://github.com/Mjnorms/Tavernlight/assets/15336051/c163feeb-5f56-48b5-b00d-f16e078e9e88

## Edit:  
I ended up implementing the effect.cpp changes in order to make the storm appear exactly as it does in the video.  
>
>int xPattern = unsigned(offsetX) % getNumPatternX();  
>xPattern = 1 - xPattern - getNumPatternX();  
>if (xPattern < 0) xPattern += getNumPatternX();  
>
>int yPattern = unsigned(offsetY) % getNumPatternY();  
>

All I had to do after that was adjust the areas in the spell!  


##  Depricated:  

It does not directly match the original, as the sprite offset of my spritesheet was different.  
I attempted to alter the offset of the sprite using an AssetEditor that I found of the OTLand forums but the tool did not work for me.  
The other option was to edit the functionality of effect.cpp and the xPattern and yPattern inputs to the draw call, but I ended up just having fun with it and creating a similar spell with the same idea.  

https://github.com/Mjnorms/Tavernlight/assets/15336051/962719bc-c4f5-4a53-a33c-29772299bea5

