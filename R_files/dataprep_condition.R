### This file takes a condition data input and formats it for connection to other dataframes with other data sources, or for analysis and plotting.

## Grab the condition data with the unique data_id and pull it in 
# this rebuilds the data structure to put it in an easier format 
condmat <- t(sapply(paste0('dataset_', data_id, '_condition_df'), function(x) eval(parse(text=x))))
colnms <- colnames(condmat)
conddata <- data.frame(mapply(function(x,y) x=condmat[[y]], x=colnms, y=1:length(colnms)))

## List of unique condition concepts we are working with
condnames <- unique(conddata['standard_concept_name'])


