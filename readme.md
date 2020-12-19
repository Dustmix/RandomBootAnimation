
# RandomBootAnimation

This script aims to set a random Bootanimation each time it is started (for example at boot).
**Note: This script requires rooting your phone.**

## Disclaimer

I'm not responsible if you damage your device, also I know this is not the best way to script but I'm not a professional.

# Setup

 1. Create a Bootanimations folder in the root (the "main folder") of the main memory.
 2. Put some Bootanimations in that folder
 3. Done  
 
 Just start the script ***as root*** and it will do everything else by itself.
**Note: You must provvide non flashable zips, they should only contain images (in folders like part01...) and desc.txt**

# Logging

You can enable logging by setting the "LOGGING" variable to 1 or creating the RBA_log.log (can be changed) file in the root of your main memory.
You can also enable "KEEPOLDLOGS" by setting it to 1, it doesn't delete the old logs when the script is started.

# Config

In the Variables section in the script you can change:

 - The Bootanimations folder with the "BOOTANIFOLDER" variable;
 - Enable (1) / Disable (0) logging via the "LOGGING" variable;
 - The log file with the "LOGFILE" variable;
 - Enable (1) / Disable (0) the "archive" of old logs via the "KEEPOLDLOGS" variable;
 - The Bootanimation.zip path with the "BOOTANIMATIONZIP" variable.
