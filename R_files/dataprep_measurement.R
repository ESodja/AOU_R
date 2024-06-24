### This file takes a measurement data input and formats it for connection to other dataframes with other data sources, or for analysis and plotting.

## Imports the measurement data as a dataframe based on unique data_id value
measmat <- t(sapply(paste0('dataset_', data_id, '_measurement_df'), function(x) eval(parse(text=x))))
colnms <- colnames(measmat)
measdata <- data.frame(mapply(function(x,y) x=measmat[[y]], x=colnms, y=1:length(colnms)))
print('Hold on, this step may take some time...')
measdata <- measdata[match(unique(measdata$person_id), measdata$person_id),]
# measdata$indivavg <- lapply(measdata$person_id, function(x) mean(measdata$value_as_number[measdata$person_id==x]))

## Check for unique measurements we are working with
meastypes <- unique(measdata['standard_concept_name'])

## What are the unique values?
measanswers <- unique(measdata['value_as_number'])
