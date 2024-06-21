### This file takes a condition data input and formats it for connection to other dataframes with other data sources, or for analysis and plotting.

## Grab the condition data with the unique data_id and pull it in 
# this rebuilds the data structure to put it in an easier format 
condmat <- t(sapply(paste0('dataset_', data_id, '_condition_df'), function(x) eval(parse(text=x))))
colnms <- colnames(condmat)
conddata <- data.frame(mapply(function(x,y) x=condmat[[y]], x=colnms, y=1:length(colnms)))

## List of unique condition concepts we are working with
condnames <- unique(conddata['standard_concept_name'])

multicond = readline(prompt='Are you comparing 2 conditions? ( Y / n )')
if (str_to_upper(multicond) == 'Y'){
    words <- strsplit(condnames[,1], "[ ,.\\(\\)\"]")
    words <- regmatches(unlist(words), gregexpr("\\b[A-Z]\\w+", unlist(words)))
    choicewords <- sort(table(unlist(words), exclude=""), decreasing=TRUE)
    print(choicewords)
    chosen = readline(prompt=paste('Which of the above are the name of your conditions you would like to test? Enter two numbers, separated by a comma (', paste(1:length(choicewords), collapse=','), ')'))
    chosen.words = choicewords[eval(parse(text=paste0('c(', chosen, ')')))]
    conddata$cond1=0
    conddata$cond1[unlist(lapply(strsplit(conddata$standard_concept_name, "[ ,.\\(\\)\"]"), function(x) any(regmatches(unlist(x), gregexpr("\\b[A-Z]\\w+", unlist(x))) %in% names(chosen.words[1]))))==TRUE] <- 1
    conddata$cond2=0
    conddata$cond2[unlist(lapply(strsplit(conddata$standard_concept_name, "[ ,.\\(\\)\"]"), function(x) any(regmatches(unlist(x), gregexpr("\\b[A-Z]\\w+", unlist(x))) %in% names(chosen.words[2]))))==TRUE] <- 1
    names(conddata) = c('person_id', 'standard_concept_name', names(chosen.words[1]), names(chosen.words[2]))
    conddat1 <- tapply(conddata[,3], conddata[,1], max)
    conddat2 <- tapply(conddata[,4], conddata[,1], max)
    conddat.unity <- merge(data.frame(person_id=names(conddat1), conddat1), data.frame(person_id = names(conddat2), conddat2), by='person_id', all=TRUE)
    conddat.unity[is.na(conddat.unity)] <- 0
}
