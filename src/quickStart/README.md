# 🚀 Quick start
This section is for those who want to improve the starting process by reducing the time it takes (and noise).
Using [this G-code](start.gcode) will disable the mesh bed leveling process and dynamic nozzle calibration options.
In other words, the printer will do only the strict minimum to start the print :
- start bed heating
- preheating the nozzle
- doing a homing
- waiting for the bed and nozzle to reach the target temperature
- starting the print.

Additionally, you can use [this G-code](filamentChange.gcode) to reduce the margin of movement that the print head makes after the end of the print. By default, it goes up by 10 cm. I noticed that this could unroll the filament a little too much, and therefore pull it out of its spool. I therefore reduced this margin to 1cm.