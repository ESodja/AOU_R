## plotting survey data against measurements 
png('surv_meas_plot.png')
boxplot(indivavg ~ answer, data=surv_meas, ylab = 'Avg. Measure by individual', xlab = 'Survey Response')
dev.off()

