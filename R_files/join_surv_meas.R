### Joins survey to measurement data
## Assumes you want only things that are common to both datasets (i.e. inner join)
## Assumes you want one measurement per individual -- most recent available
## Assumes you want one survey response per individual -- most recent available

# survdata
# measdata

# survdata is a dataframe of survey responses
# measdata is a dataframe of measurements
# connect these dataframes based on person id:
surv_meas <- merge(unique(survdata), unique(measdata), by='person_id')
# eliminate rows that have na values (both data types are not present):
surv_meas <- na.omit(surv_meas)
# average measurements for individuals that have multiple:
avgmeas <- tapply(as.numeric(surv_meas$value_as_number), surv_meas$person_id, mean)
# make a new dataframe that makes these outputs usable
avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
# connect the new dataframe to the merged survey/measurement dataframe (keeps only matches)
surv_meas <- merge(surv_meas, avgmeastab, by='person_id')
