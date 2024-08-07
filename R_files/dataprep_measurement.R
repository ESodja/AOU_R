### This file takes a measurement data input and formats it for connection to other dataframes with other data sources, or for analysis and plotting.

## Imports the measurement data as a dataframe based on unique data_id value
# this rebuilds the data structure to put it in an easier format 
# From the inside-out:
#  Define a function that runs eval(parse(text=x)) -- this will take the text entered in the variable x and 
#     turn it into a command that R will run
#  Take the data_id value from master.R, paste it into the default variable name generated by the SQL code from
#     the database builder, and run that through the defined function
#  sapply() applies the function to the value from the  paste0 function
#  t() transposes the output -- this is necessary because the database builder output is in an archaic format 
#  that does everyting backward
measmat <- t(sapply(paste0('dataset_', data_id, '_measurement_df'), function(x) eval(parse(text=x))))

# grabs the column names for later use
colnms <- colnames(measmat)

# defines a new dataframe that grabs the rows and columns of the output:
#   define a two-variable function that pulls rows and columns from the imported data and puts it in a nice, 
#   simple data frame, which is the standard base format for R
measdata <- data.frame(mapply(function(x,y) x=measmat[[y]], x=colnms, y=1:length(colnms)))

# List of unique measurement concepts we are working with -- by default, the first record for a specific person
measdata <- measdata[match(unique(measdata$person_id), measdata$person_id),]
# If you want to get the average measurement for each person, uncomment the following line and comment out the line above (this option WILL cause the analysis to run for a very long time, so if your cohort is large this will likely not work!)
# measdata$indivavg <- lapply(measdata$person_id, function(x) mean(measdata$value_as_number[measdata$person_id==x]))

# Check for unique measurements we are working with
meastypes <- unique(measdata['standard_concept_name'])

# What are the unique values?
measanswers <- unique(measdata['value_as_number'])
