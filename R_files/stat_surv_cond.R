## Statistics to compare a single survey question to presence/absence of condition(s)
# Chi-square test 
cstest <- chisq.test(x=surv_cond$answer, y=surv_cond$diagnosed)
output <- capture.output(print(cstest))
writeLines(output, con=file('surv_cond_stats.csv'))
