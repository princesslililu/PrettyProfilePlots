//choose where to save your JPEG images
output = getDirectory("Choose a data folder"); 	



//choose the colour for each channel
colours = newArray("c1", "c2", "c3", "c4", "c5", "c6", "c7"); 						// this sets up an array of colour choices in the format the 'merge channel' tool will recognise
choices = newArray("Red", "Green", "Blue", "Grey", "Cyan", "Magenta", "Yellow");	// this sets up an array of colour choices in the format the change channel colour tool will recognise
numberofchannels = newArray("1", "2", "3", "4");

//create dialog asking user to input label names
Dialog.create("Plan your pretty profile plot!");
Dialog.addChoice("How many channels?", numberofchannels, "2");

//User chooses labels for channels
Dialog.addMessage("Channel labels");
Dialog.addString("Channel 1 label", "mNeon");
Dialog.addString("Channel 2 label", "Chlorophyll");
Dialog.addString("Channel 3 label", "mCherry");
Dialog.addString("Channel 4 label", "BFP");


//Allows user to choose channel colours from a drop down menu
Dialog.addMessage("Channel colours");					
Dialog.addChoice("Channel 1 colour", choices, "Green"); 	//Creates a dialog box where you can choose the colour for channel 1. Default set to green.
Dialog.addChoice("Channel 2 colour", choices, "Red");
Dialog.addChoice("Channel 3 colour", choices, "Blue");
Dialog.addChoice("Channel 4 colour", choices, "Magenta");	//Creates a dialog box where you can choose the colour for channel 2. Default set to magenta.

Dialog.show(); //show dialog box

//get choices for which channels to include
numberofchannels1 = Dialog.getChoice();

//get the choices once dialog closed
ch1  = Dialog.getString(); 	//channel 1 label
ch2  = Dialog.getString();	//channel 2 label
ch3  = Dialog.getString();	//channel 3 label
ch4  = Dialog.getString();	//channel 4 label


//Convert colour choice for channel 1 from dialog box into usable variable
colour1 = Dialog.getChoice();								//retreives choice use makes in dialog box
for (i=0; i<choices.length; i++) { 							//this links the choice of a colour and converts it into the form recognised by the 'merge channel' tool, e.g converts 'red' to 'c1'
if (colour1 == choices[i]) {
ch1c = colours[i];
break;
 }
}

//Convert colour choice for channel 2 from dialog box into usable variable
colour2 = Dialog.getChoice();
for (i=0; i<choices.length; i++) {
if (colour2 == choices[i]) {
ch2c = colours[i];
break;
 }
}

//Convert colour choice for channel 3 from dialog box into usable variable
colour3 = Dialog.getChoice();
for (i=0; i<choices.length; i++) {
if (colour3 == choices[i]) {
ch3c = colours[i];
break;
 }
}

//Convert colour choice for channel 4 from dialog box into usable variable
colour4 = Dialog.getChoice();
for (i=0; i<choices.length; i++) {
if (colour4 == choices[i]) {
ch4c = colours[i];
break;
 }
}

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
Plot.setStyle(0, ""+colour1+",none,2,Line");
Plot.setLegend(ch1, "options");
//Plot.show();


//save a JPEG of the line used to generate plot profile
selectWindow(title);
Overlay.addSelection("white", 4); //overlays the selection/ROI with white line of width 4
run("Flatten", "slice");		  // 'flattens' the image so the ROI becomes part of the image
saveAs("Jpeg", output+File.separator+title+ch1+"ROI");	//saves new image as a JPEG



if (numberofchannels1 == 1) {
	close("Plot*");
	selectWindow(""+title+".png");
 	exit("Finished :)");
   }
      
//FOR 2 CHANNELS:
//prompt user to selct the next channel they want for the plot.
//could also use setSlice(n); if don't want user to choose.
selectWindow(title);
waitForUser("select 2nd channel");

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
Plot.setStyle(1, ""+colour2+",none,2,Line");
Plot.addLegend(ch1+"\n"+ch2+"\n", "Auto");

if (numberofchannels1 == 2) {
	Plot.show();
	}
Plot.makeHighResolution("Profile Plot_HiRes",4.0);
saveAs("PNG", output+File.separator+title+".png");

//save a JPEG of the line used to generate plot profile
selectWindow(title);
Overlay.addSelection("white", 4);
run("Flatten", "slice");
saveAs("Jpeg", output+File.separator+title+ch2+"ROI");


//FOR 3CHANNELS:

//if number of channels was 2, close any excess windows, select the high res plot and stop the macro
if (numberofchannels1 == 2) {
	close("Plot*");
	selectWindow(""+title+".png");
	exit("Finished :)");
   }


//prompt user to selct the next channel they want for the plot.
//could also use setSlice(n); if don't want user to choose.
selectWindow(title);
waitForUser("select 3rd channel");

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
Plot.setStyle(2, ""+colour3+",none,2,Line");
Plot.addLegend(ch1+"\n"+ch2+"\n"+ch3+"\n", "Auto");
if (numberofchannels1 == 3) {
	Plot.show();
	}
Plot.makeHighResolution("Profile Plot_HiRes",4.0);
saveAs("PNG", output+File.separator+title+".png");

//save a JPEG of the line used to generate plot profile
selectWindow(title);
Overlay.addSelection("white", 4);
run("Flatten", "slice");
saveAs("Jpeg", output+File.separator+title+ch3+"ROI");


//FOR 4 channels:

//if number of channels was 3, close any excess windows, select the high res plot and stop the macro
if (numberofchannels1 == 3) {
	//close all ugly plot windows
	close("Plot*");
	selectWindow(""+title+".png");
    exit("Finished :)");
   }


//prompt user to selct the next channel they want for the plot.
//could also use setSlice(n); if don't want user to choose.
selectWindow(title);
waitForUser("select 4th channel");

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
Plot.setStyle(3, ""+colour4+",none,2,Line");
Plot.addLegend(ch1+"\n"+ch2+"\n"+ch3+"\n"+ch4+"\n", "Auto");
Plot.show();
Plot.makeHighResolution("Profile Plot_HiRes",4.0);
saveAs("PNG", output+File.separator+title+".png");

//save a JPEG of the line used to generate plot profile
selectWindow(title);
Overlay.addSelection("white", 4);
run("Flatten", "slice");
saveAs("Jpeg", output+File.separator+title+ch4+"ROI");


//close all ugly plot windows
close("Plot*");

	
