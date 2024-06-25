## plotting survey data against measurements 

# opens a .png file with the given name
png('surv_meas_plot.png')

# make a plot with individual averages on the vertical axis against the survey answers on the horizontal axis
# ylab is y axis label
# xlab is x axis label
boxplot(indivavg ~ answer, data=surv_meas, ylab = 'Avg. Measure by individual', xlab = 'Survey Response')

# closes the file, so it is saved
dev.off()

