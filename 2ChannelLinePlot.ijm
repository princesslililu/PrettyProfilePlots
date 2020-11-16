//select the line drawing tool ready and then wait for user to 
//confirm they have drawn the line
setTool("line");
waitForUser("draw line");

//get the title of the window the line was drawn in
title = getTitle();

//run Plot Prfile function in ImageJ
run("Plot Profile");

//get distance (x) and intensity(y) values (same as what you get from clicking list button)
Plot.getValues(x, y);
 
//Get the max intensity value. y is the name of the array, minY and maxY are variables 
//set by me but they have to be in the 2nd and 3rd variables in the function 
Array.getStatistics(y, minY, maxY);

//make a new array with the same length as the intensity value array
normalisedY = newArray(y.length);

//populate new array by dividing all intensity values 
//by maximun intensity value to normalise to 1.
for (i=0; i<y.length; i++)
	normalisedY[i] = y[i]/maxY;

//create new line plot with normalised values
Plot.create("Profile Plot", "Distance (microns)", "Normalised intensity (a.u)", x, normalisedY);
Plot.setStyle(0, "green,none,2,Line");
Plot.setLegend("BST1:mNeon", "options");
//Plot.show();


//save a JPEG of the line used to generate plot profile
selectWindow(title);
run("Fill", "slice");
saveAs("Jpeg");

//prompt user to selct the next channel they want for the plot.
//could also use setSlice(n); if don't want user to choose.
waitForUser("select 2nd channel")

//restore/move the line ROI to the 2nd channel
run("Restore Selection");
run("Plot Profile");

//get distance (x) and intensity(y) values
Plot.getValues(x, y);
 
//Get the max intensity value. y is the name of the array, minY and maxY are variables 
//set by me but they have to be in the 2nd and 3rd variables in the function 
Array.getStatistics(y, minY, maxY);

//make a new array with the same length as the intensity value array
normalisedY = newArray(y.length);

//populate new array by dividign all intensity values 
//by maximun intensity value to normalise to 1.
for (i=0; i<y.length; i++)
	normalisedY[i] = y[i]/maxY;

Plot.add("line", x, normalisedY);
Plot.setStyle(1, "magenta,magenta,2,Line");
Plot.addLegend("BST1:mNeon\nChlorophyll\n", "Auto");
Plot.show();
Plot.makeHighResolution("Profile Plot_HiRes",4.0);
saveAs("PNG", "/Users/liatadler/OneDrive - University of Edinburgh/Lab stuff from home/Lineplotmacro/Profile Plot_HiRes-1.png");

//save a JPEG of the line used to generate plot profile
selectWindow(title);
run("Fill", "slice");
saveAs("Jpeg");



