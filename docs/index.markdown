---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: default
title: Welcome!
# permalink: /AOU24
---
    
# R recipes for the AOU summer institute 2024

## Goals: 
 - Have resources available for new users to perform simple analyses on AoU workbench data
 - Cover a range of user backgrounds and experience levels
 - Provide information that can be quickly understood and applied 
 - Provide guidance that can be used in later teaching situations
 
## Overall approach: 
The cookbook will consist of code, descriptions, implementation directions, etc. for a few basic data analysis pipelines. Absolutely new users will be able to run certain analyses without any coding necessary, while those with some experience (or a desire to learn) will be able to adapt the provided code to fit their goals. 
 
## Things to know:
Data selection for this project is handled entirely by the dataset builder. Help can be found [here](https://support.researchallofus.org/hc/en-us/articles/4556645124244-Using-the-Concept-Set-Selector-and-Dataset-Builder-tools-to-build-your-dataset).

What kinds of research questions fit with these analyses? [Check out the limits on what this system can do.](/datareqs)

Check out the basics of [R](./basics/r) and [RStudio](./basics/rstudio) to get oriented with the language and the platform we'll use on the workbench.

Download the [zip file of R scripts](/R_files.zip) to run this system, or [view them online](https://github.com/ESodja/AOU_R.git).


## How to run your analyses
### Non-coding users: 
![flowchart of files for different types of analyses](./images/flowchart_052824.png)
1. Generate your dataset on the researcher workbench
2. Initialize your RStudio cloud environment
3. Download and upload the [zip file](/R_files.zip) to the cloud environment (it will unzip automatically)
4. Copy the SQL code into 'Data_import.R'
5. Type `source('master.R')` into the RStudio console and press `Enter` or `Return`, and answer the questions that come up in the console
6. Look at the outputs and download your plots and statistical reports.

[Detailed non-coding instructions with screenshots](/how-to/non-coding)

[Example of non-coding workflow](/examples/bmi_noncoding)

### Coding (or “coding curious”) users:
1. Generate your dataset on the researcher workbench
2. Initialize your RStudio cloud environment
3. Download and upload the [zip file](/R_files.zip) to the cloud environment (it will unzip automatically)
4. Copy the SQL code into 'Data_import.R'
5. Determine the analysis you would like to run and which files need to be run to accomplish that
6. Identify and modify code to adjust the existing system to do what you want it to
7. Type `source('filename.R')` into the RStudio console and press `Enter` or `Return` for each file in order, from top to bottom of the flowchart
8. Look at the outputs and download your plots and statistical reports


If changes to plots are necessary, the user can open the plotting files (bottom row of the flowchart) and follow instructions to modify the code. 

If joins of multiple data types need to be modified, the R file(s) used in the next row up on the flowchart should be modified (instructions will be included in the file). 


After modifying the files, it is a good idea to restart R (click on session > Restart R) and run each file individually from the beginning to make sure the results are correct.

Download the necessary output files.

[Detailed coding instructions with screenshots](/how-to/coding)

[Example of coding workflow](/examples/bmi_coding)


## Other resources
[Using RStudio on the Researcher Workbench](https://support.researchallofus.org/hc/en-us/articles/22078658566804-Using-RStudio-on-the-Researcher-Workbench)



## Contact
[Email me!](mailto:eric.sodja@utah.edu)




