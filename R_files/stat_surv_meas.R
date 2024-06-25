### Runs an ANOVA analysis on survey responses relative to a measured value
# run a linear model of the measurement vaule against survey answers
surv_meas_mod <- lm(value_as_number ~ answer, data=surv_meas)
# put outputs in anova table format
anova.out <- anova(surv_meas_mod)
# generate output table
write.csv(anova.out, 'surv_meas_anova_table.csv')
