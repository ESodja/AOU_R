## Runs statistics for two sets of condition data. Both conditions are set as presence/absence of diagnosis.

# if we are working with a single condition...
if(str_to_upper(multicond) != 'Y'){
    conddata$diagnosis = 1

    # changes dataset from long to wide format, so there is a column for each condition type and a row for each person
    conddat_wide <- reshape(conddata, idvar='person_id', timevar='standard_concept_name', direction = 'wide')
    
    # changes na values to 0, since this means the individual is not diagnosed
    conddat_wide[is.na(conddat_wide)] = 0

    # builds a table of all the possible condition combinations
    which.compare = data.frame(expand.grid(condnames[,1], condnames[,1]))
    # which.compare = data.frame(expand.grid(c(1:ncol(numeric_answers)), c(1:ncol(numeric_answers))))
    # eliminates the duplicated condition combinations
    which.compare = which.compare[!duplicated(t(apply(which.compare, 1, sort))),]
    # eliminates condition combinations that are the same
    which.compare = which.compare[which.compare$Var1 != which.compare$Var2,]

    # runs a chisquare test on each combination of conditions
    cor.table <- data.frame(mapply(function(x,y) chisq.test(conddat_wide[,paste0('diagnosis.',x)], conddat_wide[,paste0('diagnosis.',y)]), x=which.compare$Var1, y= which.compare$Var2))

    # reset names to match which comparisons are being done
    names(cor.table) = apply(which.compare, 1, paste, collapse=' vs. ')

# if we are working with multiple conditions
} else {
    # count up the responses in your data
    cstable <- table(unique(conddat.unity)[,c(2,3)])
    # fill in the last data in the corner -- 252209 is the number of possible condition datapoints (i.e. people with health record access)
    cstable[1,1] <- 252209 - sum(cstable)
    # run a chi square test on the frequency table
    cstest <- chisq.test(cstable)
    # generate an output
    output <- capture.output(print(c(cstest)))
    writeLines(output, con=file('cond_cond_stats.csv'))
}
    
