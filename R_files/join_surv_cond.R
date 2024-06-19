### Joins survey to condition data
## Assumes you want all available survey data and what condition data is available (i.e. left join)
## Assumes you want one condition per individual -- most recent available
## Assumes you want one survey response per individual -- most recent available

# survdata
# conddata
if(cnd_type == 'sing_pa' | cnd_type == 'mult_pa'){
    conddata$diagnosed <- 1
    surv_cond <- merge(unique(survdata), unique(conddata), by='person_id', all.x=TRUE)
    surv_cond$diagnosed[is.na(surv_cond$diagnosed)] <- 0
} else if (cnd_type == 'mult_pa2'){
    conddata$diagnosed <- 1
    conddata$diagnosed[conddata$standard_concept_name == condnames[2,]] <- 2
    surv_cond <- merge(unique(survdata), unique(conddata), by='person_id', all.x=TRUE)
    surv_cond$diagnosed[is.na(surv_cond$diagnosed)] <- 0
}
