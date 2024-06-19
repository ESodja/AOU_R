### Runs an ANOVA analysis on conditions (diagnosis) relative to a measured value
cond_meas_mod <- lm(value_as_number ~ as.factor(diagnosed), data=cond_meas)
anova.out <- anova(cond_meas_mod)
write.csv(anova.out, 'cond_meas_anova_table.csv')
