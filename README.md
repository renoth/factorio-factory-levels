# factorio-factory-levels
A mod for factorio [Link to mod portal](https://mods.factorio.com/mod/factory-levels)

You want Assemblers and Furnaces that upgrade with more Items produced and smelted?
This is the mod for you.

## Building the mod
 
 With maven installed issue the following command:
 
 `mvn assembly:single install`
 
 The target folder should now contain the mod zip file. All zipfiles from the target-folder will get copied to the configured factorio mod folder.
 
 The factorio mod folder can be configured in
 
 `src/config.properties`
