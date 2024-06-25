## Takes data from two survey questions and runs analysis on how much 
## they agree with each other. If they are categorical answers, it will
## use chi square analysis, and if one or both are ordinal/numberical
## e.g. Likert scale responses, it will use an anova or correlation test
## as appropriate.

# change data from long to wide format
survdata_wide = reshape(survdata, idvar='person_id', timevar='question', direction = 'wide')

# reads in the package "stringr" which helps with character value manipulation
require(stringr)

# pulls numbers out of responses based on a regular expression
numeric_answers = matrix(unlist(lapply(2:ncol(survdata_wide), function(y) lapply(str_extract_all(survdata_wide[,y], pattern ='\\(?[0-9,.]+\\)?'), function(x) as.numeric(x[1])))), ncol=3)

# if we add up the columns and they are not all na values, there is at least numerical answer for the survey answer
if (all(!is.na(colSums(numeric_answers)))){
  # make a table of all the interactions between survey questions
  which.compare = data.frame(expand.grid(survqs[,1], survqs[,1]))
  # which.compare = data.frame(expand.grid(c(1:ncol(numeric_answers)), c(1:ncol(numeric_answers))))
  # isolate the combinations to the ones that are unique, regardless of order
  which.compare = which.compare[!duplicated(t(apply(which.compare, 1, sort))),]
  # eliminate the combinations that are the same question 
  which.compare = which.compare[which.compare$Var1 != which.compare$Var2,]
  
  # run a correlation between each combination of questions
  cor.table <- data.frame(mapply(function(x,y) cor.test(numeric_answers[,x], numeric_answers[,y]), x=which.compare$Var1, y= which.compare$Var2))
  
  # name the output table to match with each question combination
  names(cor.table) = apply(which.compare, 1, paste, collapse=' vs. ')
  
  # write an output table
  write.csv(cor.table, 'survey_question_correlation.csv')
  
# if we have any na values in the column sums, there is something that is not a numeric survey answer
} else if (any(is.na(colSums(numeric_answers)))){
  # Somebody is categorical
  # converts survey data where converting to numeric returns an na value into a factor (i.e. categorical/ordinal data)
  survdata_factor = data.frame(lapply(2:ncol(survdata_wide[which(is.na(colSums(numeric_answers)))]), function(x) as.factor(survdata_wide[,x])))
  # rename columns
  names(survdata_factor) <- names(survdata_wide[,c(2:ncol(survdata_wide))])
  # survdata_factor = lapply(2:ncol(survdata_wide), function(x) as.factor(survdata_wide[,x]))
  
  # ask the user 
  ordinal = readline('Some of these data are categorical. Are any of them also ordinal? (y/n)')
  # if the user indicates there is an ordinal element
  if (str_to_upper(ordinal) == 'Y'){
    # set a default for if there are more ordinal data to go through
    more.ordinal='Y'
    # a collector for which columns are ordinal data
    ordinals = c()
    # print out the names of columns with potential ordinal data
    print(names(survdata_wide[,2:ncol(survdata_wide)]))
    # user indicates which column is ordinal
    which.ordinal = readline(paste0('Which of the above survey data are ordinal? (enter one of ', paste(1:(ncol(survdata_wide)-1), collapse=', '), ')'))
    # add the indicated ordinal column to the list of ordinal data
    ordinals = as.numeric(c(ordinals, which.ordinal))
    # get the order of the factor in the given column from the user
    print('What is the order? For example, if the data have values of b, d, f, e, a, c, the order would be 5, 1, 6, 2, 4, 3 (i.e. the 5th letter should be in the 1st spot, the 1st letter should be in the 2nd spot, etc.) to set the order as a, b, c, d, e, f. Enter numbers separated by commas.')
    # user input
    neworder = readline(paste(levels(survdata_factor[[as.numeric(which.ordinal)]]), collapse=', \n'))
    # extract the order from the user input
    order.ordinal = sapply(paste0('c(', neworder, ')'), function(x) eval(parse(text=x)))
    # set the levels attribute for the factors in the column (defines the order of the factors, or possible values)
    levels(survdata_factor[[as.numeric(which.ordinal)]]) = levels(survdata_factor[[as.numeric(which.ordinal)]])[order.ordinal]
    # ask the user if there are any other ordinal factors in the data
    which.ordinal = readline(paste('Any others? (enter one of ', paste(1:(ncol(survdata_wide)-1), collapse=', '), ')'))
    # if the user says nothing, the answer is no
    if(which.ordinal == '') more.ordinal <- 'n'
    # if there are more, go through the whole process again
    while(str_to_upper(more.ordinal)=='Y' & length(ordinals) < ncol(survdata_factor)){
      ordinals = as.numeric(c(ordinals, which.ordinal))
      print('What is the order? For example, if the data have values of b, d, f, e, a, c, the order would be 5, 1, 6, 2, 4, 3 (i.e. the 5th letter should be in the 1st spot, the 1st letter should be in the 2nd spot, etc.) to set the order as a, b, c, d, e, f. Enter numbers separated by commas.')
      new.order = readline(paste(levels(survdata_factor[[as.numeric(which.ordinal)]]), collapse=', \n'))
      order.ordinal = sapply(paste0('c(', new.order, ')'), function(x) eval(parse(text=x)))
      levels(survdata_factor[[as.numeric(which.ordinal)]]) = levels(survdata_factor[[as.numeric(which.ordinal)]])[order.ordinal]
      which.ordinal = readline(paste('Any others? (enter one of ', paste(1:(ncol(survdata_wide)-1), collapse=', '), 'or press ENTER for no more ordinal factors)'))
      if(which.ordinal == '') more.ordinal <- 'n'
    }
  }
  # get all possible combinations of survey questions, as above
  which.compare = data.frame(expand.grid(survqs[,1], survqs[,1]))
  # which.compare = data.frame(expand.grid(c(1:ncol(numeric_answers)), c(1:ncol(numeric_answers))))
  which.compare = which.compare[!duplicated(t(apply(which.compare, 1, sort))),]
  which.compare = which.compare[which.compare$Var1 != which.compare$Var2,]
  # make a table with the frequency of each combination of responses and run a chi square test on them
  fact.table <- data.frame(mapply(function(x,y) chisq.test(table(survdata_factor[,c(x,y)])), x=which.compare$Var1, y= which.compare$Var2))
  # rename the table
  names(fact.table) = apply(which.compare, 1, paste, collapse=' vs. ')
  # generate and save the chi square output table
  output <- capture.output(print(c(fact.table)))
  writeLines(output, con=file('surv_surv_stats.csv'))
#   write.csv(fact.table, 'survey_question_chisq.csv')
}
