# **R recipes for the *All Of Us* Summer Institute 2024**

## Goals: 
 - Have resources available for new users to perform simple analyses on AoU workbench data
 - Cover a range of user backgrounds and experience levels
 - Provide information that can be quickly understood and applied 
 - Provide guidance that can be used in later teaching situations
 
## Overall approach: 
The cookbook will consist of code, descriptions, implementation directions, etc. for a few basic data analysis pipelines. Absolutely new users will be able to run certain analyses without any coding necessary, while those with some experience (or a desire to learn) will be able to adapt the provided code to fit their goals. 
 
## Getting Started
For instructions on how to get started with this cookbook, [look at the github page](https://esodja.github.io/AOU_R).
That page has information on [setting up appropriate workspaces and analyses](https://esodja.github.io/AOU_R/datareqs) that will work with this cookbook, basics to [get started with R](https://esodja.github.io/AOU_R/basics/r) and [RStudio](https://esodja.github.io/AOU_R/basics/rstudio), more [in-depth](https://esodja.github.io/AOU_R/pages-overview#code-explanations) explanations of each type of file, and [examples](https://esodja.github.io/AOU_R/pages-overview#examples) for how to run analyses, copy workspaces, etc.

## Basic structure
The entire cookbook can be modified to be used as independent parts, but how it is set up here enables non-coding analysis access to the All Of Us researcher workbench via RStudio.
Users must generate the dataset using the dataset builder on the AOU researcher workbench, according to [specific requirements](https://esodja.github.io/AOU_R/datareqs).
Users of this automated structure can run `master.R` to initiate data import, after which the system will ask a series of questions which the user will answer in the Console in RStudio.
Users working with modified code will likely have to run each R script individually in sequence, from top to bottom of the flowchart below.

![flowchart of files for different types of analyses](https://esodja.github.io/AOU_R/assets/images/flowchart_062024.png)

## Files in the cookbook
### Initialization/Inputs
- [Data_import.R](https://github.com/ESodja/AOU_R/blob/main/R_files/Data_import.R)
- [master.R](https://github.com/ESodja/AOU_R/blob/main/R_files/master.R)

### Data preparation
- [dataprep_condition.R](https://github.com/ESodja/AOU_R/blob/main/R_files/dataprep_condition.R)
- [dataprep_survey.R](https://github.com/ESodja/AOU_R/blob/main/R_files/dataprep_survey.R)
- [dataprep_measure.R](https://github.com/ESodja/AOU_R/blob/main/R_files/dataprep_measure.R)

### Joining data types
- [join_cond_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/join_cond_meas.R)
- [join_surv_cond.R](https://github.com/ESodja/AOU_R/blob/main/R_files/join_surv_cond.R)
- [join_surv_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/join_surv_meas.R)

### Analysis
- [stat_cond_cond.R](https://github.com/ESodja/AOU_R/blob/main/R_files/stat_cond_cond.R)
- [stat_cond_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/stat_cond_meas.R)
- [stat_surv_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/stat_surv_meas.R)
- [stat_surv_cond.R](https://github.com/ESodja/AOU_R/blob/main/R_files/stat_surv_cond.R)
- [stat_surv_surv.R](https://github.com/ESodja/AOU_R/blob/main/R_files/stat_surv_surv.R)
- [stat_meas_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/stat_meas_meas.R)

### Plotting
- [plot_cond_cond.R](https://github.com/ESodja/AOU_R/blob/main/R_files/plot_cond_cond.R)
- [plot_cond_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/plot_cond_meas.R)
- [plot_surv_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/plot_surv_meas.R)
- [plot_surv_cond.R](https://github.com/ESodja/AOU_R/blob/main/R_files/plot_surv_cond.R)
- [plot_surv_surv.R](https://github.com/ESodja/AOU_R/blob/main/R_files/plot_surv_surv.R)
<!-- - [plot_meas_meas.R](https://github.com/ESodja/AOU_R/blob/main/R_files/plot_meas_meas.R) -->

    
## How to run your analyses
### Non-coding users: 
1. [Generate your dataset](https://esodja.github.io/AOU_R/how-to/dataset) on the researcher workbench
2. [Initialize](https://esodja.github.io/AOU_R/how-to/non-coding#2.-initialize-your-rstudio-cloud-environment) your RStudio cloud environment
3. [Import](https://esodja.github.io/AOU_R/how-to/non-coding#3.-import-the-cookbook-files) the R scripts to RStudio
4. [Copy](https://esodja.github.io/AOU_R/how-to/non-coding#4.-copy-the-sql-code-to-data_import.r) the SQL code from the dataset builder into 'Data_import.R'
5. [Type](https://esodja.github.io/AOU_R/how-to/non-coding#5.-run-the-program) `source('master.R')` into the RStudio console and press `Enter` or `Return`, and answer the questions that come up in the console
6. [Look](https://esodja.github.io/AOU_R/how-to/non-coding#6.-look-at-the-outputs) at the outputs and download your plots and statistical reports
7. [Delete](https://esodja.github.io/AOU_R/how-to/non-coding#7.-delete-your-cloud-environment) your cloud environment

[Detailed non-coding instructions with screenshots](https://esodja.github.io/AOU_R/how-to/non-coding)

[Example of non-coding workflow](https://esodja.github.io/AOU_R/examples/bmi_noncoding)

### Coding (or “coding curious”) users:
1. [Generate your dataset](https://esodja.github.io/AOU_R/how-to/dataset) on the researcher workbench
2. [Initialize](https://esodja.github.io/AOU_R/how-to/non-coding#2.-initialize-your-rstudio-cloud-environment) your RStudio cloud environment
3. [Import](https://esodja.github.io/AOU_R/how-to/non-coding#3.-import-the-cookbook-files) the R scripts to RStudio
4. [Copy](https://esodja.github.io/AOU_R/how-to/non-coding#4.-copy-the-sql-code-to-data_import.r) the SQL code from the dataset builder into 'Data_import.R'
5. [Determine](https://esodja.github.io/AOU_R/how-to/coding#5.-determine-analyses-to-run) the analysis you would like to run and which files to modify, if any
6. [Type](https://esodja.github.io/AOU_R/how-to/coding#6.-run-each-file-in-order-in-the-console) `source('filename.R')` into the RStudio console and press `Enter` or `Return` for each file in order, from top to bottom of the flowchart
7. [Look](https://esodja.github.io/AOU_R/how-to/coding#7.-view-and-download-the-generated-outputs) at the outputs and download your plots and statistical reports
8. [Delete](https://esodja.github.io/AOU_R/how-to/coding#8.-delete-your-cloud-environment) your cloud environment

[Detailed coding instructions with screenshots](https://esodja.github.io/AOU_R/how-to/coding)

[Example of coding workflow](https://esodja.github.io/AOU_R/examples/bmi_coding) 

Data selection for this project is handled entirely by the dataset builder. Help can be found [here](https://support.researchallofus.org/hc/en-us/articles/4556645124244-Using-the-Concept-Set-Selector-and-Dataset-Builder-tools-to-build-your-dataset).



## Other resources
[using RStudio on the Researcher Workbench](https://support.researchallofus.org/hc/en-us/articles/22078658566804-Using-RStudio-on-the-Researcher-Workbench)



## Contact
[Email me!](mailto:eric.sodja@utah.edu)




