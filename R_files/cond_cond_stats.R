## Runs statistics for two sets of condition data. Both conditions are set as presence/absence
## of diagnosis.

conddata$diagnosis = 1

conddat_wide <- reshape(conddata, idvar='person_id', timevar='standard_concept_name', direction = 'wide')
conddat_wide[is.na(conddat_wide)] = 0

which.compare = data.frame(expand.grid(condnames[,1], condnames[,1]))
# which.compare = data.frame(expand.grid(c(1:ncol(numeric_answers)), c(1:ncol(numeric_answers))))
which.compare = which.compare[!duplicated(t(apply(which.compare, 1, sort))),]
which.compare = which.compare[which.compare$Var1 != which.compare$Var2,]

cor.table <- data.frame(mapply(function(x,y) chisq.test(conddat_wide[,paste0('diagnosis.',x)], conddat_wide[,paste0('diagnosis.',y)]), x=which.compare$Var1, y= which.compare$Var2))

names(cor.table) = apply(which.compare, 1, paste, collapse=' vs. ')
