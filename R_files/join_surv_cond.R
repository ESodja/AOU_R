### Joins survey to condition data
## Assumes you want all available survey data and what condition data is available (i.e. left join)
## Assumes you want one condition per individual -- most recent available
## Assumes you want one survey response per individual -- most recent available

# survdata
# conddata

# if the condition type is a single presence/absence or a multiple presence absence, we treat them like presence/absence of all the things as one thing
if(cnd_type == 'sing_pa' | cnd_type == 'mult_pa'){
    # set default condition diagnosis status in the condition data -- if they are in this table, they have the condition
    conddata$diagnosed <- 1
    # connects unique rows of condition data to unique rows of survey data based on the person id
    # keeps all the survey data, but if there is a condition entry without a survey for a person, that person is left out
    surv_cond <- merge(unique(survdata), unique(conddata), by='person_id', all.x=TRUE)
    # clean up na values for conditions by setting them to 0 (anyone with an na in condition column doesn't have the condition)
    surv_cond$diagnosed[is.na(surv_cond$diagnosed)] <- 0
    
# if the condition type is mult_pa2 (exactly 2 conditions listed) we assume you want to compare the two conditions
} else if (cnd_type == 'mult_pa2'){
    # set default condition diagnosis status in the condition data -- if they are in this table, they have the condition
    conddata$diagnosed <- 1
    # if their condition is the second condition, we are calling that diagnosis 2, as in they have condition 2
    conddata$diagnosed[conddata$standard_concept_name == condnames[2,]] <- 2
    # merge tables (unique rows) by person id, and keep all the measure data
    surv_cond <- merge(unique(survdata), unique(conddata), by='person_id', all.x=TRUE)
    # clean up na diagnosis values (they don't have anything) by setting them equal to 0
    surv_cond$diagnosed[is.na(surv_cond$diagnosed)] <- 0
}
