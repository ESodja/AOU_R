## Plots analyses with two survey questions
png('surv_surv_plot_nums.png', width=1000)
barplot(table(survdata_factor), ylab='Individuals', 
        xlab=as.character(which.compare[,1]), legend.text=TRUE, args.legend=list(x='topright'), col=2:length(unique(survdata_factor[,1])))
dev.off()

png('surv_surv_plot_prop.png', width=1000)
barplot(table(survdata_factor)/rep(colSums(table(survdata_factor)), each=2),
        xlab=as.character(which.compare[,1]), legend.text=TRUE, args.legend=list(x='bottomright'), col=2:length(unique(survdata_factor[,1])))
dev.off()
