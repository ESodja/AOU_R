### This file takes a survey data input and formats it for connection to other dataframes with other data sources, or for analysis and plotting.
library(parallel)

## Imports the survey data as a dataframe based on unique data_id value

# this rebuilds the data structure to put it in an easier format 
# From the inside-out:
#  Define a function that runs eval(parse(text=x)) -- this will take the text entered in the variable x and 
#     turn it into a command that R will run
#  Take the data_id value from master.R, paste it into the default variable name generated by the SQL code from
#     the database builder, and run that through the defined function
#  sapply() applies the function to the value from the  paste0 function
#  t() transposes the output -- this is necessary because the database builder output is in an archaic format 
#  that does everyting backward
survmat <- t(sapply(paste0('dataset_', data_id, '_survey_df'), function(x) eval(parse(text=x))))

# grabs the column names for later use
colnms <- colnames(survmat)

# converts the matrix in survmat into a dataframe so it will be easier to work with
survdata <- data.frame(mapply(function(x,y) x=survmat[[y]], x=colnms, y=1:length(colnms)))

# Filters out non-answers (skip, don't know, or prefer not to answer)
survdata <- survdata[survdata$answer %in% c('PMI: Skip','PMI: Dont Know', 'PMI: Prefer Not To Answer') == FALSE,]
# If there is a survey column name, filters that out
if('survey' %in% names(survdata)){
    survdata <- survdata[,names(survdata)[names(survdata) != 'survey']]
}

# Check for unique questions we are working with
survqs <- data.frame(q=unique(survdata['question']), N=0)

# Check for unique answers we are working with
survans <- data.frame(q=unique(survdata[c('question','answer')]), N=0)

# For now, multiple answer survey questions are not supported
