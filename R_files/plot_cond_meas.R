### Plots for measurements for a given condition

png('cond_meas_plot.png')
boxplot(indivavg ~ diagnosed, data=cond_meas, ylab = 'Avg. Measurement by Individual', xlab='Diagnosed')
dev.off()
