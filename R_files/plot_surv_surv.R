## Plots analyses with two survey questions
# two plots -- one with full numbers, one with proportions

# opens a .png file with the given name
# width is the width in pixels of the output file
png('surv_surv_plot_nums.png', width=1000)

# make a plot with individual averages on the vertical axis against the diagnosis status on the horizontal axis
# ylab is y axis label
# xlab is x axis label
# table() gets counts of repsonses in the table
# legend.text determines if there is a legend
# args.legend=list(x='topright') controls where the legend is on the plot (other options are 'bottomleft', 'top', 'right', etc.
# col gives the colors of the bars, these can be a list of colors such as c('red', 'blue', 'purple') etc.
barplot(table(survdata_factor), ylab='Individuals', 
        xlab=as.character(which.compare[,1]), legend.text=TRUE, args.legend=list(x='topright'), col=2:length(unique(survdata_factor[,1])))

# closes the plot file so it is saved
dev.off()

png('surv_surv_plot_prop.png', width=1000)
barplot(table(survdata_factor)/rep(colSums(table(survdata_factor)), each=2),
        xlab=as.character(which.compare[,1]), legend.text=TRUE, args.legend=list(x='bottomright'), col=2:length(unique(survdata_factor[,1])))
dev.off()
