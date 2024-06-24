### Used to run scripts in specific orders; specific to RStudio ctrl+enter line by line running

# If the repository was cloned, we need a different directory
if('./R_files' %in% list.dirs(recursive=TRUE)) setwd('/home/rstudio/AOU_R/R_files')

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
data_correct = 'Y' # default answer
data_correct = readline(prompt='Is this correct? [Y/n] ')
# if data is correct, detect the variables in the dataframes
if (str_to_upper(data_correct) == 'Y'){
    ## Level 1: specific to which data was pulled from AOU database
    if (cond_in == TRUE){ 
      source('dataprep_condition.R')
      print('Sample of included conditions:')
      print(head(condnames))
    }
    if (meas_in == TRUE){
      source('dataprep_measurement.R')
      print('Sample of included measurements:')
      print(head(meastypes))
    }
    if (surv_in == TRUE){
      source('dataprep_survey.R')
      print('Sample of included survey questions:')
      print(head(survqs))
    }
} else {
  stop('Please check the database input that you put in Data_import.R')
}

# Look for possible data connections
combotable <- unique(expand.grid(condition = c(FALSE, cond_in), survey=c(FALSE, surv_in), measurement=c(FALSE, meas_in))) 
combotable = combotable[which(rowSums(combotable) > 0 & rowSums(combotable) < 3),]
rownames(combotable) = NULL
combotable$compare = lapply(lapply(apply(combotable, 1, function(x)which(x==TRUE)), names), paste, collapse='-')
if(any(combotable$compare == '')) combotable$compare = colnames(combotable[which(combotable==TRUE)])
print('The potential data comparisons I can see are these:')
print(cbind(1:nrow(combotable), combotable[,ncol(combotable)]))
which_analysis = readline(prompt=paste('Which of these would you like to run? (', paste(1:nrow(combotable), collapse=', '),') '))
# if there is a single TRUE in a row, that could be within that data type
# if there is two TRUE's in a row, those data types could be compared
# if there are more than two, the dataset brought in is probably too complicated for an automated system
# get the row of selected data types
tf_types = unlist(combotable[which_analysis,][which(data_pres==TRUE)])
# names of columns where the selected datatype is TRUE
tf_names = names(tf_types[tf_types==TRUE])
cnd_type = 'none'
srv_type = 'none'
mmt_type = 'none'

if ('condition' %in% tf_names) {
#   source('dataprep_condition.R')
  if (length(condnames[,1]) > 2){
    print('More than 2 conditions detected; analysis will be run as presence/absence of all conditions')
    cnd_type = 'mult_pa'
  } else if (length(condnames[,1] == 2 & length(tf_names)==1 & 'condition' %in% names(tf_names))){
    print('2 conditions detected; analysis will be run as presence-absence of both conditions')
    cnd_type = 'mult_pa'
  } else if (length(condnames[,1] == 1 & length(tf_names)==1 & 'condition' %in% names(tf_names))){
    print('1 condition detected; analysis will compare presence/absence of condition against another data type')
    cnd_type = 'sing_pa'
  }
}
if ('survey' %in% tf_names) {
#   source('dataprep_survey.R')
  # test for survey answer type (single answer or multiple response)
  if (length(survqs[,1]) > 2){
    stop('More than 2 survey questions detected; analysis will require custom configuration')
  } else if (length(survqs[,1]) == 2 & length(tf_names) == 1 & 'survey' %in% tf_names) {
    print('Detected 2 survey questions; responses will be analyzed against each other')
    srv_type = '2q'
  } else if (length(survqs[,1]) == 1 & length(tf_names) == 2) {
    print('Detected 1 survey question; survey responses will be compared against other data types.')
    srv_type = '1q'
  }
}
if ('measurement' %in% tf_names) {
#   source('dataprep_measurement.R')
  if (length(meastypes) >= 2 & length(tf_names) == 1 & 'measurement' %in% names(tf_names)){
    print('Detected 2 or more measurements to compare against each other')
    mmt_type = '2meas'
  } else if ( length(meastypes) == 1 & length(tf_names) == 2) {
    print('Detected 1 measurement to compare to another data type')
    mmt_type = '1meas'
#   } else if(length(meastypes[,1] >2)){
#     print('Detected too many measurements; this analysis requres custom configuration')
#    break
  }
}
    
if (mmt_type == '2meas' & srv_type == 'none' & cnd_type == 'none'){
    print('Comparing two measurements for each individual')
    source('stat_meas_meas.R')
    source('plot_meas_meas.R')
} else if (mmt_type == 'none' & srv_type == '2q' & cnd_type == 'none'){
    print('Comparing two survey answers for each individual')
    source('stat_surv_surv.R')
    source('plot_surv_surv.R')
} else if (mmt_type == 'none' & srv_type == 'none' & cnd_type == 'mult_pa'){
    print('Comparing two conditions for each individual')
    source('stat_cond_cond.R')
    source('plot_cond_cond.R')
} else if (mmt_type == '1meas' & srv_type == '1q' & cnd_type == 'none'){
    # one measured value against one survey question
    print('Comparing a measurement against a survey question')
    source('join_surv_meas.R')
    source('plot_surv_meas.R')
    source('stat_surv_meas.R')
} else if (mmt_type == '1meas' & srv_type == 'none' & cnd_type == 'mult_pa'){
    # one measured value against p/a of several conditions
    print('Comparing a measurement against presence/absence of several conditions')
    source('join_cond_meas.R')
    source('plot_cond_meas.R')
    source('stat_cond_meas.R')
} else if (mmt_type == '1meas' & srv_type == 'none' & cnd_type == 'sing_pa'){
    # one measured value against p/a of one condition
    print('Comparing a measurement against presence/absence of a single condition')
    source('join_cond_meas.R')
    source('plot_cond_meas.R')
    source('stat_cond_meas.R')
} else if (mmt_type == 'none' & srv_type == '1q' & cnd_type == 'mult_pa'){
    # one survey question against p/a of several conditions
    print('Comparing a survey response against presence/absence of several conditions')
    source('join_surv_cond.R')
    source('plot_surv_cond.R')
    source('stat_surv_cond.R')
} else if (mmt_type == 'none' & srv_type == '1q' & cnd_type == 'sing_pa'){
    # one survey question against p/a of one condition
    print('Comparing a survey response against presence/absence of a single condition')
    source('join_surv_cond.R')
    source('plot_surv_cond.R')
    source('stat_surv_cond.R')
} else if (mmt_type == '2meas' & srv_type == 'none' & cnd_type == 'sing_pa'){
    # two measured values against p/a of one condition
    print('Comparing two measured values against presence/absence of a single condition')
    source('join_cond_meas.R')
    source('plot_cond_meas.R')
    source('stat_cond_meas.R')
} else if (mmt_type == '2meas' & srv_type == 'none' & cnd_type == 'mult_pa2'){
    # two measured values against p/a of two conditions
    print('Comparing two measured values against presence/absence of two conditions')
    source('join_cond_meas.R')
    source('plot_cond_meas.R')
    source('stat_cond_meas.R')
    
} else print('This analysis may be too complex for an automated analysis system; try subsetting data in the dataset builder according to the group(s) you would like to compare. See data_reqs.md page on the github site for more information.')


## Level 2: Data joins
# source('join_surv_meas.R')
# source('join_surv_cond.R')
# source('join_cond_meas.R')

## Level 3: plotting
# source('plot_surv_meas.R')
# source('plot_surv_cond.R')
# source('plot_cond_meas.R')


## Example: looking for BMI relative to lung conditions
# source('dataprep_condition.R')
# source('dataprep_measurement.R')
# source('join_cond_meas.R')
# source('plot_cond_meas.R')
# source('cond_meas_anova.R')
