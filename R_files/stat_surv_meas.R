### Runs an ANOVA analysis on survey responses relative to a measured value
surv_meas_mod <- lm(value_as_number ~ answer, data=surv_meas)
anova.out <- anova(surv_meas_mod)
write.csv(anova.out, 'surv_meas_anova_table.csv')
