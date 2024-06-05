### Used to run scripts in specific orders; specific to RStudio ctrl+enter line by line running


## Universal for all workflows
source('Data_import.R')
### This will take the id of the imported data and make the following steps use it for pulling data into the analysis
# grabs the data id from your sql import, unique to each database builder output 
data_id <- strsplit(ls(pattern='\\_df$')[[1]], '_')[[1]][2]

# test for presence of each type of data
cond_in = exists(paste0('dataset_',data_id,'_condition_df'))
surv_in = exists(paste0('dataset_',data_id,'_survey_df'))
meas_in = exists(paste0('dataset_',data_id,'_measurement_df'))
data_pres = c(condition = cond_in, survey = surv_in, measurement = meas_in)
print(paste('Detected data types', paste(names(data_pres[data_pres==TRUE]), collapse=', ')))
# user input to whether the detected data are the same as what they intended
data_correct = readline(prompt='Is this correct? [Y/n] ')
# if data is correct, detect the variables in the dataframes
if (str_to_upper(data_correct) == 'Y'){
    ## Level 1: specific to which data was pulled from AOU database
    if (cond_in) source('dataprep_condition.R'); print('Sample of included conditions:'); print(head(condnames))
    if (meas_in) source('dataprep_measurement.R'); print('Sample of included measurements:'); print(head(meastypes))
    if (surv_in) source('dataprep_survey.R'); print('Sample of included survey questions:'); print(head(survqs))
} else print('Please check the database input that you put in Data_import.R')

# Look for possible data connections
combotable <- unique(expand.grid(condition = c(FALSE, cond_in), survey=c(FALSE, surv_in), measurement=c(FALSE, meas_in))) 
combotable = combotable[which(rowSums(combotable) > 0),]
combotable$compare = lapply(lapply(apply(combotable, 1, function(x)which(x==TRUE)), names), paste, collapse='-')
print('The potential data comparisons I can see are these:')
print(cbind(1:nrow(combotable), combotable[,ncol(combotable)]))
which_analysis = readline(prompt=paste('Which of these would you like to run?', paste(1:nrow(combotable), collapse=', ')))
# if there is a single TRUE in a row, that could be within that data type
# if there is two TRUE's in a row, those data types could be compared
# if there are more than two, the dataset brought in is probably too complicated for an automated system
if (rowSums(combotable[which_analysis, 1:length(data_pres[data_pes==TRUE])]) == 1){
    # check that there are 2+ elements in that dataset to compare
    # run a file that compares the data type to itself
} else if (rowSums(combotable[which_analysis, 1:length(data_pres[data_pes==TRUE])]) == 2){
    # make sure there is only one element in each data type to compare
    # run the file that joins and compares these data
} else if (rowSums(combotable[which_analysis, 1:length(data_pres[data_pes==TRUE])]) > 2){
    print('This analysis may be too complex for an automated analysis system; try subsetting data in the dataset builder according to the group(s) you would like to compare. See data_reqs.md page on the github site for more information.')
}
    


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
