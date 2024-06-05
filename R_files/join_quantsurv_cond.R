### Joins survey to condition data
## Assumes you want all available survey data and what condition data is available (i.e. left join)
## Assumes you want one condition per individual -- most recent available
## Assumes you want one survey response per individual -- most recent available

# survdata
# conddata

quantsurv_cond <- merge(unique(quantsurv), unique(conddata), by='person_id', all.x=TRUE)
quantsurv_cond$standard_concept_name[is.na(quantsurv_cond$standard_concept_name)] <- 'none'
