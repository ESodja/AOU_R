### Used to run scripts in specific orders; specific to RStudio ctrl+enter line by line running


## Universal for all workflows
source('Data_import.R')
### This will take the id of the imported data and make the following steps use it for pulling data into the analysis
data_id <- strsplit(ls()[[1]], '_')[[1]][2]


## Level 1: specific to which data was pulled from AOU database
# source('dataprep_condition.R')
# source('dataprep_measurement.R')
# source('dataprep_survey.R')

## Level 2: Data joins
# source('join_surv_meas.R')
# source('join_surv_cond.R')
# source('join_cond_meas.R')

## Level 3: plotting
# source('plot_surv_meas.R')
# source('plot_surv_cond.R')
# source('plot_cond_meas.R')


## Example: looking for BMI relative to lung conditions
source('dataprep_condition.R')
source('dataprep_measurement.R')
source('join_cond_meas.R')
source('plot_cond_meas.R')
source('cond_meas_anova.R')
