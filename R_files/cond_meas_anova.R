### Runs an ANOVA analysis on multiple conditions relative to a measured value
meas_cond_mod <- lm(value_as_number ~ standard_concept_name.x, data=cond_meas)
anova.out <- anova(meas_cond_mod)
write.csv(anova.out, 'cond_meas_anova_table.csv')
