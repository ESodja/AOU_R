### Plots for measurements for a given condition; may generate several plots

## For systems with multiple (>2) or strictly single conditions to test for
# treated as presence/absence of all or just one
png('cond_survey_plot.png')
counts <- t(table(surv_cond[c('answer','diagnosed')]))
proportion <- counts/rep(colSums(counts), each=2)
barplot(proportion, legend.text=c('undiagnosed','diagnosed'), col=2:(ncol(proportion)+1))
mapply(text, x=rep(1:ncol(proportion)-0.25, each=nrow(proportion)), y=unlist(lapply(1:ncol(proportion), function(x) cumsum(proportion[,x])))-0.2, label = paste0(round(proportion, 2)*100, '%'))
# boxplt <- mapply(function(cond, surv, place, cond_set, max_cond) {
#   place.adj <- place %% max_cond
#   if(place %% max_cond == 1) {
#     add.me = FALSE
#   } else { 
#     add.me = TRUE 
#     if (place %% max_cond == 0) place.adj <- max_cond
#   }
#   ylms = range(as.numeric(surv_cond[surv_cond$standard_concept_name.y == surv & surv_cond$standard_concept_name.x %in% condnames[[1]][1:7],"value_as_number"]))
#   bp <- boxplot(as.formula('as.numeric(value_as_number) ~ standard_concept_name.x'), 
#           data=surv_cond[surv_cond$standard_concept_name.y == surv & is.finite(as.numeric(surv_cond$value_as_number)) & cond_meas$standard_concept_name.x %in% cond,],
#           add=add.me,
#           at=place.adj,
#           xlims=c(0,max_cond+0.5),
#           ylab='',
#           names=cond,
#           ylimx=ylms)
#   #print(bp)
#   return(bp)
# }, 
# cond=condnames[[1]][1:7], 
# # meas=meastypes[[1]],
# place=1:length(condnames[[1]][1:7]),
# cond_set=rep(1:length(condnames[[1]][1:7]), each=max_cond, length.out=length(condnames[[1]][1:7])),
# max_cond=max_cond)

mtext('Proportion Diagnosed', side=2, line=3)
# xlab.height = min(matrix(unlist(boxplt[1,]), nrow=5)[1,])-6.4
# spltlabs = lapply(strsplit(condnames[[1]][1:7], ' '), function(x) {
#   if(length(x) > 3){
#     starts = seq(1,(length(x)+1),3)
#     ends = c(seq(starts[2],(length(x)+1),3)-1, length(x))
#   } else { 
#     starts = 1
#     ends = length(x)
#   }
#   paste(lapply(1:length(starts), function(y) paste(c(x[starts[y]:ends[y]], '\n'), collapse=' ')), collapse=' ')
# } )
# text(x=1:length(condnames[[1]][1:7]), y=xlab.height, xpd=TRUE, labels=spltlabs, srt=0)
dev.off()
