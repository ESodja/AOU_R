### Joins condition to measurement data
## Assumes you want all available measurement data and what condition data is available (i.e. left join)
## Assumes you want one condition per individual -- most recent available
## Assumes you want one measurement per individual -- most recent available

# conddata
# measdata

cond_meas <- merge(unique(conddata), unique(measdata), by='person_id', all.y=TRUE)