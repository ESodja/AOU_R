### Joins condition to measurement data
## Assumes you want all available measurement data and what condition data is available (i.e. left join)
## Assumes you want one condition per individual -- most recent available
## Assumes you want one measurement per individual -- most recent available

# conddata
# measdata

if(cnd_type == 'sing_pa' | cnd_type == 'mult_pa'){
    conddata$diagnosed <- 1
    
    cond_meas <- merge(unique(conddata), unique(measdata), by='person_id', all.y=TRUE)
#     cond_meas <- na.omit(cond_meas)
    avgmeas <- tapply(as.numeric(cond_meas$value_as_number), cond_meas$person_id, mean, na.rm=TRUE)
    avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
    cond_meas <- merge(cond_meas, avgmeastab, by='person_id')
    
    cond_meas$diagnosed[is.na(cond_meas$diagnosed)] <- 0
} else if (cnd_type == 'mult_pa2'){
    conddata$diagnosed <- 1
    conddata$diagnosed[conddata$standard_concept_name == condnames[2,]] <- 2
    
    cond_meas <- merge(unique(conddata), unique(measdata), by='person_id', all.y=TRUE)
#     cond_meas <- na.omit(cond_meas)
    avgmeas <- tapply(as.numeric(cond_meas$value_as_number), cond_meas$person_id, mean)
    avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
    cond_meas <- merge(cond_meas, avgmeastab, by='person_id')
    
    cond_meas$diagnosed[is.na(cond_meas$diagnosed)] <- 0
}

# cond_meas <- merge(unique(conddata), unique(measdata), by='person_id', all.y=TRUE)
# cond_meas <- na.omit(cond_meas)
# avgmeas <- tapply(as.numeric(cond_meas$value_as_number), cond_meas$person_id, mean)
# avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
# cond_meas <- merge(cond_meas, avgmeastab, by='person_id')
