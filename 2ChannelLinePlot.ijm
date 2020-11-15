waitForUser("draw line");
run("Clear Results");
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

//create new line plot with normalised values
Plot.create("Profile Plot", "Distance (microns)", "Normalised intensity (a.u)", x, normalisedY);
Plot.setStyle(0, "green,none,2,Line");
Plot.setLegend("BST1:mNeon", "options");
//Plot.show();

waitForUser("select 2nd channel")
run("Restore Selection");

run("Clear Results");
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