# Preparing data for analysis
Pulling data into R is easy with the dataset builder interface.
Once you've constructed your dataset, copy the SQL code to the `Data_import.R` file -- you can either click the copy button or view preview, highlight, and paste the code to the file.
Make sure to save after you make these changes.

## Preparing survey data
Survey data has a lot of categorical answers, often a ``Likert scale'' of "Strongly Agree" to "Strongly Disagree".
Some survey questions allow for multiple answers, which makes importing them somewhat trickier.
The code below will format the data into a dataframe and extract the unique questions.
[This also needs to make the multiple response questions work somehow...]
![Data preparation for survey data](https://github.com/esodja/main/blob/dataprep_survey.R)

## Preparing measurement data
Measurement data is almost always numeric data. 
If you're using multiple measurements, they will come in the same data, so the measurements will need to be separated by their label.
The code below imports the data from the SQL script and indentifies the measuements included in the data.
![Data preparation for measurement data](https://github.com/esodja/main/blob/dataprep_measurement.R)

## Preparing condition data
Condition data lists whether a given individual has been diagnosed with a specific condition.
Often these are a series of related conditions, so at this time all conditions in the data are treated as the same "condition of interest" for your analysis. 
This can be changed by [think of something]
The code below imports the condition data and counts how many conditions are in the data.
![Data preparation for condition data](https://github.com/esodja/main/blob/dataprep_condition.R)
