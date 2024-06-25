### Plots for measurements for a given condition

# opens a .png file with the given name
png('cond_meas_plot.png')

# make a plot with individual averages on the vertical axis against the diagnosis status on the horizontal axis
# ylab is y axis label
# xlab is x axis label
boxplot(indivavg ~ diagnosed, data=cond_meas, ylab = 'Avg. Measurement by Individual', xlab='Diagnosed')

# closes the file, so it is saved
dev.off()
