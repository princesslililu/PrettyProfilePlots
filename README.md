# PrettyProfilePlots
This is an ImageJ macro to automatically generate pretty two channel line profile plots.
It generates a high-res plot as a .png file, and also two JPEGs of the line you draw on each channel image.

Currently running the macro in ImageJ:
Version: 2.0.0-rc-71/1.52p
Build: ea9a94b5e9
(I just installed Fiji)

I install by going through the ImageJ GUI:
Plugins>macros>Install... and then selecting the .ijm file.

I believe there are other ways though such as putting macro in a file named "StartupMacros.txt" in the macros folder where it will automatically be installed when ImageJ starts up.

Please note:
I wrote the macro for image stacks/channels opened as a single window. If you want to split the channels you might need to tweak the macro for it to work.
