---
layout: page
title: Noncoding Example
permalink: /Examples/BMI_noncoding
---

Example: Lung conditions and BMI
As an example, we can compare measurement data (BMI) and condition data (presence of few different lung conditions). 

1. Get the necessary data from the dataset creator from the AOU website.
2. Open RStudio on the Workbench and import the R files from this repository.

> If you copy-paste code into a new file, make sure to name the file the same as it was in this repository!

3. Copy-paste the SQL import text from the dataset builder to `Data_import.r`.
4. In the RStudio console, type `source('master.R')` and hit `enter` or `return`.
5. Answer the prompts [still under development].
6. Find the generated files in the files panel.

This analysis generates a box plot and ANOVA analysis:

![boxplot of conditions relative to BMI](/images/plot_cnd_meas.png)



|           | Df     | Sum Sq           | Mean Sq          | F value          | Pr(>F) | 
|-----------|--------|------------------|------------------|------------------|--------| 
| Condition | 681    | 739549.87851589  | 1085.97632674874 | 17.8777921095185 | 0      |
| Residuals | 443282 | 26926913.2969462 | 60.7444319799725 |                  |        |
