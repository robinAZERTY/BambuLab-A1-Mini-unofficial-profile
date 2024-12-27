# 🚀 Multicolor without AMS
If you don't have an AMS, you can use [this gcode](filamentChange.gcode). Then you can use the slicer as if you had an AMS. The only difference is that you will have to change the filament manually...!

## 📝 Steps
When a color change is needed, the printer will pause at the right moment. Once paused, you can follow these steps:
- unload the current filament
- load the next filament by pushing into the PTFE tube until the endStop
- press resume

It will purge the nozzle following the flush volume and filament settings in the slicer.

📬 Contact
I took [this gcode](filamentChange.gcode) from an other github repository. I don't remember which one, but if you recognize it, please let me know so I can credit the author. 