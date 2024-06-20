### This file takes a survey data input and formats it for connection to other dataframes with other data sources, or for analysis and plotting.
library(parallel)

## Imports the survey data as a dataframe based on unique data_id value
# This takes the survey dataframe from the SQL code and converts it into a dataframe we can use;
# all the fancy 'sapply' and 'function' stuff just makes it so that any survey data you choose will 
# get put into the variable 'survmat'
survmat <- t(sapply(paste0('dataset_', data_id, '_survey_df'), function(x) eval(parse(text=x))))
# grabs the column names for later use
colnms <- colnames(survmat)
# converts the matrix in survmat into a dataframe so it will be easier to work with
survdata <- data.frame(mapply(function(x,y) x=survmat[[y]], x=colnms, y=1:length(colnms)))
# Filters out non-answers (skip, don't know, or prefer not to answer)
survdata <- survdata[survdata$answer %in% c('PMI: Skip','PMI: Dont Know', 'PMI: Prefer Not To Answer') == FALSE,]
if('survey' %in% names(survdata)){
    survdata <- survdata[,names(survdata)[names(survdata) != 'survey']]
}

## Check for unique questions we are working with
survqs <- data.frame(q=unique(survdata['question']), N=0)
survans <- data.frame(q=unique(survdata[c('question','answer')]), N=0)

## Need to check the survey question type -- some are multiple responses, which makes things trickier
# this will total the number of responses from each person, and check to see if there is variation in the number of responses
# for (q in survqs){
#     survqs$N[survqs$q==q] = pmax.int(unlist(mclapply(survdata[survdata$question==q,]$person_id, function(x) sum(survdata$person_id==x), mc.cores=4, mc.preschedule=FALSE)))
# #     responsesperperson = any(unlist(mclapply(survdata[survdata$question==q,]$person_id, function(x) sum(survdata$person_id==x), mc.cores=detectCores(), mc.preschedule=FALSE)) > 1)
#     
# }
# 
# if(any(survqs$N > 1)){
#     # do... something
# }
