# 🚀 Multicolor without AMS
If you don't have an AMS, you can use [this gcode](change%20fillement.gcode). Then you can use the slicer as if you had an AMS. The only difference is that you will have to change the filament manually...!

## ✅ Objectives
I know that manually changing the filament is not very convenient for multicolor prints, unless you have plenty of time to spare. However, I find it to be a good solution for small prints that require only one or two color changes, like this example :

<img src="../../doc/multicolor%20without%20AMS%20example.jpg" alt="this example" width="300"/>

Another practical use is printing support interfaces with a soluble filament or PETG, while printing the object with PLA. Of course, this approach works best when the support interfaces are concentrated in just a few layers to minimize filament changes.
## 📝 Steps
When a color change is needed, the printer will pause at the right moment. Once paused, you can follow these steps:
- unload the current filament
- load the next filament by pushing into the PTFE tube until the endStop
- press resume

It will purge the nozzle following the flush volume and filament settings in the slicer.

## 📬 Credits
Credits go to [pakonambawan](https://github.com/pakonambawan) and [Hillbilly-Phil](https://github.com/Hillbilly-Phil) who submit a solution to addapt [this project](https://github.com/eukatree/Bambu_CustomGCode) for the A1 mini [here](https://github.com/eukatree/Bambu_CustomGCode/issues/10#issuecomment-2263087821).
