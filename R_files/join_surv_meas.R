### Joins survey to measurement data
## Assumes you want only things that are common to both datasets (i.e. inner join)
## Assumes you want one measurement per individual -- most recent available
## Assumes you want one survey response per individual -- most recent available

# survdata
# measdata

surv_meas <- merge(unique(survdata), unique(measdata), by='person_id')
