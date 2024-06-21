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
 
## Overview
This cookbook consists of code, descriptions, implementation directions, etc. for a few basic data analyses. 
Certain analyses can be run without any coding necessary, but users with some experience (or a desire to learn) will be able to adapt the provided code to fit their goals. 

Most of the pages are listed [here](/AOU_R/pages-overview).

 
## Things to know:
The approach I've developed here only covers specific types of data from the dataset builder. [Check out the limits on what this system can do.](/AOU_R/datareqs)

Check out the basics of [R](/AOU_R/basics/r) and [RStudio](/AOU_R/basics/rstudio) to get oriented with the language and the platform we'll use on the workbench.

You can [view the R scripts online](https://github.com/ESodja/AOU_R.git), but the instructions include an easy way to import the files directly into RStudio.

### Copying a workspace
We will use a pre-made workspace for the examples in the instutute. Instructions to copy the workspace to your own account are [here](/AOU_R/how-to/copyworkspace).

## How to run your analyses
### Non-coding users: 
1. [Generate your dataset](/AOU_R/how-to/dataset) on the researcher workbench
2. [Initialize](/AOU_R/how-to/non-coding#initialize-your-rstudio-cloud-environment) your RStudio cloud environment
3. [Import](/AOU_R/how-to/non-coding#import-the-cookbook-files) the R scripts to RStudio
4. [Copy](/AOU_R/how-to/non-coding#copy-the-sql-code-to-data_import.r) the SQL code from the dataset builder into 'Data_import.R'
5. [Type](/AOU_R/how-to/non-coding#run-the-program) `source('master.R')` into the RStudio console and press `Enter` or `Return`, and answer the questions that come up in the console
6. Look at the outputs and download your plots and statistical reports.

[Detailed non-coding instructions with screenshots](/AOU_R/how-to/non-coding)

[Example of non-coding workflow](/AOU_R/examples/bmi_noncoding)

### Coding (or “coding curious”) users:
1. [Generate your dataset](/AOU_R/how-to/dataset) on the researcher workbench
2. [Initialize](/AOU_R/how-to/non-coding#initialize-your-rstudio-cloud-environment) your RStudio cloud environment
3. [Import](/AOU_R/how-to/non-coding#import-the-cookbook-files) the R scripts to RStudio
4. [Copy](/AOU_R/how-to/non-coding#copy-the-sql-code-to-data_import.r) the SQL code from the dataset builder into 'Data_import.R'
5. [Determine](/how-to/coding#determine-analyses-to-run) the analysis you would like to run and which files to modify, if any
6. [Type](/AOU_R/how-to/coding#run-each-file-in-order-in-the-console) `source('filename.R')` into the RStudio console and press `Enter` or `Return` for each file in order, from top to bottom of the flowchart
7. Look at the outputs and download your plots and statistical reports

[Detailed coding instructions with screenshots](/AOU_R/how-to/coding)

[Example of coding workflow](/AOU_R/examples/bmi_coding)


## Other resources
- [Using RStudio on the Researcher Workbench](https://support.researchallofus.org/hc/en-us/articles/22078658566804-Using-RStudio-on-the-Researcher-Workbench)



## Contact
[Email me!](mailto:eric.sodja@utah.edu)




