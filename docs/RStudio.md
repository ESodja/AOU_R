---
layout: default
title: RStudio Basics
permalink: /basics/rstudio
---

This is an introduction to basic use of RStudio.

## R vs. RStudio -- what is the difference?
[R](https://www.r-project.org/) is a programming language, [RStudio](https://posit.co/products/open-source/rstudio/) is an "Integrated Development Environment" (IDE) that collects all the pieces of R in one place to make it easier to use. Take a look at my [introduction to the basics of R](/basics/r).

In short, RStudio is just one of many ways to use R. 
It is popular because it combines may of the things that R can do in easy to understand graphical interfaces. 
For example, if you want to create a plot of some data in R, you would use the `plot` function, enter the name of your data into the command, and a new window opens with the plot. 
If you run `plot` again, R will overwrite your plot with the new one unless you change a few different options or use specific functions to make this not happen.
In RStudio, plots are displayed in a "plot" tab that keeps old plots when it generates a new one. 
This allows you to look back at previous plots by clicking the forward and backward arrows.

## Downloading R Studio (optional)
RStudio is installed on the All of Us workbench servers so you don't have to install it on your computer; however, you may want to do so if you are interested in learning the interface more in-depth so you don't have to deal with all the sign in details just to mess around on R or RStudio.
After you install R (download it [here](https://cran.rstudio.com/)) RStudio can be downloaded [here](https://posit.co/download/rstudio-desktop/) and installed on your computer.

## The parts of RStudio
By default, RStudio shows three panels when you first open it: [screenshot]
The left side of the window is the Console/Terminal/Background Jobs panel, the top right is the Environment/History/Connections/Tutorial panel, and the bottom right has the files/plots/packages/help/viewer/presentation panel.

### The console
The console is where R is actually running.
You can enter commands in the console one at a time and get instant feedback from R. 
The console also keeps a record of previously run commands so you can scroll up and find out why your results look so awesome (or try to find where you made a mistake...). 

The terminal connects directly to your computer (or whatever RStudio is installed on).
Most people will not need to use this.

Background jobs are large processes that take long enough that you want to do other things while you're waiting.
Most users won't need to use this.

### The environment
The environment panel keeps track of the previously named objects in your R session.
For example, if you want to save a string of text for later, you might enter `my_string <- 'this is my string'` into the console.
When you do, the environment tab will update showing the object by name and the contents (or for large objects, a sample of the contents) to remind you of what is in the object.
This is especially helpful when you have a lot of objects you are working with.

The history tab gives a history of commands entered in the console, including anything run from the script pane (see below).
This may be helpful instead of scrolling up in the console because some operations have long outputs.
The history pane does not show those outputs, only the commands that were entered, making it easier to look back at your previous work.

Connections allows you to connect to outside databases; for our purposes this is not necessary.

The tutorial tab allows you to go through a tutorial for how to use RStudio and R. 
First you must install the `learnr` package by clicking where it says `click here`.
This loads basic tutorials for tasks like entering and using data, characterizing tables, and so on.

### The files pane
The files tab is a directory of where your session of R is running, usually in your Documents folder by default.
You can add, delet, and rename folders, files, etc. from this tab.

The plots tab shows any graphics generated in your R session.
Click the left and right arrows in the top left of the pane to cycle back and forth through previously generated plots. 
You can export a plot to save it using the export button, and if you would like to pop a plot out into a separate window you can click zoom. 
If your plotting commands become very slow, you might have too many plots in your history. 
You can delete the currently visible plot by clicking the red X button, or clear all plots by clicking the broom.

The packages tab allows you to attach and detach packages.
Packages are pre-built extensions of R that enable or simplify specific functionality in R.
The packages listed in the packages tab are those installed on your system; to install a package not listed, you can click `Tools > Install packages...` in the top menu. 
Type the name(s) of the package(s) and click ok, and the package will install.
To use a package, you can click the box next to the package name in the packages tab.
To load a package every time you run a script, you can add `library(package_name)` to the top of your script.

The help tab allows you to access the help files for any installed and loaded packages' functions.
In the search bar, enter the name of a function. 
If there is a function with that name, the help pages for that function will display; if the name is not recognized, a list of close matches will appear so you can choose the function you were looking for.

Viewer and presentation tabs are beyond the scope of this guide.

### Scripting pane
Once you start to write scripts (see the [R introduction page](/basics/r)) the script panel will be useful.
Click on the green '+' in the top left corner of the window and select `R Script`.
A new panel will open in the top left for your R scripts.
You can write code in this panel and save it as a .R file to use later. 
You can also run code from this panel by placing the cursor on a line of code and pressing `ctrl+enter` on Windows or `cmd+return` on a Mac to run that line of code and move the cursor to the next line.
This can be very useful for testing out individual pieces of code as you write.

You can also run an entire script by clicking on `Source` in the top right of the script panel.

If you want to run a script that is not open (for example, if you have finished designing that part of your code and don't need to modify it further) you can run it by typing `source('myscript.R')` in the console, or adding that line to another script.

## Conclusion
RStudio has a lot of options for changing the look and feel of the IDE, including changing color schemes, panel locations, and even text entry options (Vim, Emacs, etc.). 
In its default configuration, though, RStudio provides a useful structure to learn how to code and use R for anything you want to work on.
