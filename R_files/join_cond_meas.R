### Joins condition to measurement data
## Assumes you want all available measurement data and what condition data is available (i.e. left join)
## Assumes you want one condition per individual -- most recent available
## Assumes you want one measurement per individual -- most recent available

# conddata
# measdata

# master.R identifies if the condition is a single presence/absence or if there are multiple conditions we are testing for
# because many of the conditions are full of sub-conditions that are more specific types of the broader condition category

# if the condition type is a single presence/absence or a multiple presence absence, we treat them like presence/absence of all the things as one thing
if(cnd_type == 'sing_pa' | cnd_type == 'mult_pa'){
    # set default condition diagnosis status in the condition data -- if they are in this table, they have the condition
    conddata$diagnosed <- 1
    # connects unique rows of condition data to unique rows of measure data based on the person id
    # keeps all the measurement data, but if there is a condition entry without a measurement for a person, that person is left out
    cond_meas <- merge(unique(conddata), unique(measdata), by='person_id', all.y=TRUE)
#     cond_meas <- na.omit(cond_meas)
    # gets the average of all measures for a given person, and ignores the na values (average of anything with na is just na)
    avgmeas <- tapply(as.numeric(cond_meas$value_as_number), cond_meas$person_id, mean, na.rm=TRUE)
    # sorts the results into a dataframe for people with their average measure
    avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
    # merges the average measures with the condition-measure table by person id
    cond_meas <- merge(cond_meas, avgmeastab, by='person_id')
    # clean up na values for conditions by setting them to 0 (anyone with an na in condition column doesn't have the condition)
    cond_meas$diagnosed[is.na(cond_meas$diagnosed)] <- 0
    
# if the condition type is mult_pa2 (exactly 2 conditions listed) we assume you want to compare the two conditions
} else if (cnd_type == 'mult_pa2'){ 
    # set default condition diagnosis status in the condition data -- if they are in this table, they have the condition
    conddata$diagnosed <- 1
    # if their condition is the second condition, we are calling that diagnosis 2, as in they have condition 2
    conddata$diagnosed[conddata$standard_concept_name == condnames[2,]] <- 2
    # merge tables (unique rows) by person id, and keep all the measure data
    cond_meas <- merge(unique(conddata), unique(measdata), by='person_id', all.y=TRUE)
#     cond_meas <- na.omit(cond_meas)
    # get the average measures for a given measure for a given person, in case anyone has multiple measurements
    avgmeas <- tapply(as.numeric(cond_meas$value_as_number), cond_meas$person_id, mean)
    # sort everything into a data frame
    avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
    # connect that dataframe to the original cond_meas data frame
    cond_meas <- merge(cond_meas, avgmeastab, by='person_id')
    # clean up na diagnosis values (they don't have anything) by setting them equal to 0
    cond_meas$diagnosed[is.na(cond_meas$diagnosed)] <- 0
}

# cond_meas <- merge(unique(conddata), unique(measdata), by='person_id', all.y=TRUE)
# cond_meas <- na.omit(cond_meas)
# avgmeas <- tapply(as.numeric(cond_meas$value_as_number), cond_meas$person_id, mean)
# avgmeastab <- data.frame(person_id = rownames(avgmeas), indivavg = avgmeas)
# cond_meas <- merge(cond_meas, avgmeastab, by='person_id')
