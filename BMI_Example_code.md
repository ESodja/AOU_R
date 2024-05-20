Example: Lung conditions and BMI
As an example, we can compare measurement data (BMI) and condition data (presence of few different lung conditions). 

1. Get the necessary data from the dataset creator from the AOU website.
2. Open RStudio on the Workbench and import the R files from this repository.

> If you copy-paste code into a new file, make sure to name the file the same as it was in this repository!

3. Copy-paste the SQL import text from the dataset builder to `Data_import.r`.

If you're only lightly modifying the code (i.e. [changing the plot details](https://github.com/ESodja/AOU_R/blob/main/Plot_modification.md), [selecting a subset of variables](https://github.com/ESodja/AOU_R/blob/main/Variable_modification.md), anything that doesn't change the type of data you want to compare), you can still use the main workflow:

4. In the RStudio console, type `source('master.R')` and hit `enter` or `return`.
5. Answer the prompts [still under development].
6. Find the generated files in the files panel.

This analysis generates a box plot and ANOVA analysis:

![boxplot of conditions relative to BMI](plot_cnd_meas.png) [update with tweaked outputs]


|           | Df     | Sum Sq           | Mean Sq          | F value          | Pr(>F) | 
|-----------|--------|------------------|------------------|------------------|--------| 
| Condition | 681    | 739549.87851589  | 1085.97632674874 | 17.8777921095185 | 0      |
| Residuals | 443282 | 26926913.2969462 | 60.7444319799725 |                  |        |


If you've changed any of the main analyses (i.e. added variables or otherwise), you may have to run files individually by tracing them back on the flowchart and renaming the variables. For example:

[alternate analysis with a few minor tweaks to specific files]

