### Joins survey to measurement data
## Assumes you want only things that are common to both datasets (i.e. inner join)
## Assumes you want one measurement per individual -- most recent available
## Assumes you want one survey response per individual -- most recent available

# survdata
# measdata

surv_meas <- merge(unique(survdata), unique(measdata), by='person_id')
surv_meas <- na.omit(surv_meas)
avgmeas <- tapply(as.numeric(surv_meas$value_as_number), surv_meas$person_id, mean)
avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
surv_meas <- merge(surv_meas, avgmeastab, by='person_id')

