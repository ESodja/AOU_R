## Statistics to compare a single survey question to presence/absence of condition(s)
# Chi-square test for survey answers against diagnosis
cstest <- chisq.test(x=surv_cond$answer, y=surv_cond$diagnosed)
# generate an output
output <- capture.output(print(cstest))
writeLines(output, con=file('surv_cond_stats.csv'))
