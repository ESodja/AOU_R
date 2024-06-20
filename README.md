# **R recipes for the AOU summer institute 2024**

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

![flowchart of files for different types of analyses](./assets/images/flowchart_052824.png)

## How to run your analyses
### Non-coding users: 
1. [Generate your dataset](./how-to/dataset) on the researcher workbench
2. [Initialize](/how-to/non-coding#initialize-your-rstudio-cloud-environment) your RStudio cloud environment
3. [Import](/how-to/non-coding#import-the-cookbook-files) the R scripts to RStudio
4. [Copy](/how-to/non-coding#copy-the-sql-code-to-data_import.r) the SQL code from the dataset builder into 'Data_import.R'
5. [Type](/how-to/non-coding#run-the-program) `source('master.R')` into the RStudio console and press `Enter` or `Return`, and answer the questions that come up in the console
6. Look at the outputs and download your plots and statistical reports.

[Detailed non-coding instructions with screenshots](./how-to/non-coding)

[Example of non-coding workflow](./examples/bmi_noncoding)

### Coding (or “coding curious”) users:
1. [Generate your dataset](./how-to/dataset) on the researcher workbench
2. [Initialize](/how-to/non-coding#initialize-your-rstudio-cloud-environment) your RStudio cloud environment
3. [Import](/how-to/non-coding#import-the-cookbook-files) the R scripts to RStudio
4. [Copy](/how-to/non-coding#copy-the-sql-code-to-data_import.r) the SQL code from the dataset builder into 'Data_import.R'
5. [Determine](/how-to/coding#determine-analyses-to-run) the analysis you would like to run and which files to modify, if any
6. [Type](/how-to/coding#run-each-file-in-order-in-the-console) `source('filename.R')` into the RStudio console and press `Enter` or `Return` for each file in order, from top to bottom of the flowchart
7. Look at the outputs and download your plots and statistical reports

[Detailed coding instructions with screenshots](./how-to/coding)

[Example of coding workflow](./examples/bmi_coding) 

Data selection for this project is handled entirely by the dataset builder. Help can be found [here](https://support.researchallofus.org/hc/en-us/articles/4556645124244-Using-the-Concept-Set-Selector-and-Dataset-Builder-tools-to-build-your-dataset).



## Other resources
[using RStudio on the Researcher Workbench](https://support.researchallofus.org/hc/en-us/articles/22078658566804-Using-RStudio-on-the-Researcher-Workbench)



## Contact
[Email me!](mailto:eric.sodja@utah.edu)




