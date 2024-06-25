### Runs an ANOVA analysis on conditions (diagnosis) relative to a measured value
# implements a linear model of the measurement value against the diagnosis state
cond_meas_mod <- lm(value_as_number ~ as.factor(diagnosed), data=cond_meas)
# put the results in anova table format
anova.out <- anova(cond_meas_mod)
# generate an output table
write.csv(anova.out, 'cond_meas_anova_table.csv')
