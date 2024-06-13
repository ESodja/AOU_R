## Takes data from two survey questions and runs analysis on how much 
## they agree with each other. If they are categorical answers, it will
## use chi square analysis, and if one or both are ordinal/numberical
## e.g. Likert scale responses, it will use an anova or correlation test
## as appropriate.

survdata_wide = reshape(survdata, idvar='person_id', timevar='question', direction = 'wide')

require(stringr)
numeric_answers = matrix(unlist(lapply(2:ncol(survdata_wide), function(y) lapply(str_extract_all(survdata_wide[,y], pattern ='\\(?[0-9,.]+\\)?'), function(x) as.numeric(x[1])))), ncol=3)

if (all(!is.na(colSums(numeric_answers, na.rm=TRUE)))){
  
  which.compare = data.frame(expand.grid(survqs[,1], survqs[,1]))
  # which.compare = data.frame(expand.grid(c(1:ncol(numeric_answers)), c(1:ncol(numeric_answers))))
  which.compare = which.compare[!duplicated(t(apply(which.compare, 1, sort))),]
  which.compare = which.compare[which.compare$Var1 != which.compare$Var2,]
  
  cor.table <- data.frame(mapply(function(x,y) cor.test(numeric_answers[,x], numeric_answers[,y]), x=which.compare$Var1, y= which.compare$Var2))
  
  names(cor.table) = apply(which.compare, 1, paste, collapse=' vs. ')
  
  write.csv(cor.table, 'survey_question_correlation.csv')
} else if (any(is.na(colSums(numeric_answers, na.rm=TRUE)))){
  # Somebody is categorical
  survdata_factor = lapply(2:ncol(survdata_wide)[which(is.na(colSums(numeric_answers, na.rm=TRUE)))], function(x) as.factor(survdata_wide[,x]))
  # survdata_factor = lapply(2:ncol(survdata_wide), function(x) as.factor(survdata_wide[,x]))
  
  ordinal = readline('Some of these data are categorical. Are any of them also ordinal? (y/n)')
  if (ordinal == 'y'){
    more.ordinal='y'
    ordinals = c()
    print(names(survdata_wide[,2:ncol(survdata_wide)]))
    which.ordinal = readline(paste0('Which of the above survey data are ordinal? (enter one of ', paste(1:(ncol(survdata_wide)-1), collapse=', '), ')'))
    ordinals = as.numeric(c(ordinals, which.ordinal))
    print('What is the order? For example, if the data have values of b, d, f, e, a, c, the order would be 5, 1, 6, 2, 4, 3 to set the order as a, b, c, d, e, f. Enter numbers separated by commas.')
    neworder = readline(paste(levels(survdata_factor[[as.numeric(which.ordinal)]]), collapse=', \n'))
    order.ordinal = sapply(paste0('c(', neworder, ')'), function(x) eval(parse(text=x)))
    levels(survdata_factor[[as.numeric(which.ordinal)]]) = levels(survdata_factor[[as.numeric(which.ordinal)]])[order.ordinal]
    while(more.ordinal=='y' & length(ordinals) < length(ncol(survdata_factor))){
      which.ordinal = readline(paste('Any others? (enter one of ', paste(1:(ncol(survdata_wide)-1), collapse=', '), ')'))
      ordinals = as.numeric(c(ordinals, which.ordinal))
      print('What is the order? For example, if the data have values of b, d, f, e, a, c, the order would be 5, 1, 6, 2, 4, 3 to set the order as a, b, c, d, e, f. Enter numbers separated by commas.')
      new.order = readline(paste(levels(survdata_factor[[as.numeric(which.ordinal)]]), collapse=', \n'))
      order.ordinal = sapply(paste0('c(', new.order, ')'), function(x) eval(parse(text=x)))
      levels(survdata_factor[[as.numeric(which.ordinal)]]) = levels(survdata_factor[[as.numeric(which.ordinal)]])[order.ordinal]
    }
  }
  which.compare = data.frame(expand.grid(survqs[,1], survqs[,1]))
  # which.compare = data.frame(expand.grid(c(1:ncol(numeric_answers)), c(1:ncol(numeric_answers))))
  which.compare = which.compare[!duplicated(t(apply(which.compare, 1, sort))),]
  which.compare = which.compare[which.compare$Var1 != which.compare$Var2,]
  fact.table <- data.frame(mapply(function(x,y) chisq.test(survdata_factor[[x]], survdata_factor[[y]]), x=which.compare$Var1, y= which.compare$Var2))
  names(fact.table) = apply(which.compare, 1, paste, collapse=' vs. ')
  write.csv(fact.table, 'survey_question_chisq.csv')
}
