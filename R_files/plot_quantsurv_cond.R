### Plots for measurements for a given condition; may generate several plots
max_cond = 7
boxplt <- mapply(function(cond, qsurv, place, cond_set, max_cond) {
  place.adj <- place %% max_cond
  if(place %% max_cond == 1) {
    add.me = FALSE
  } else { 
    add.me = TRUE 
    if (place %% max_cond == 0) place.adj <- max_cond
  }
  ylms = range(as.numeric(quantsurv_cond[surv_cond$standard_concept_name.y == qsurv & quantsurv_cond$standard_concept_name.x %in% condnames[[1]][1:7],"answer"]))
  bp <- boxplot(as.formula('as.numeric(answer) ~ standard_concept_name.x'), 
          data=quantsurv_cond[quantsurv_cond$standard_concept_name.y == qsurv & is.finite(as.numeric(quantsurv_cond$answer)) & quantsurv_cond$standard_concept_name.x %in% cond,],
          add=add.me,
          at=place.adj,
          xlims=c(0,max_cond+0.5),
          ylab='',
          names=cond,
          ylimx=ylms)
  return(bp)
  }, 
  cond=condnames[[1]][1:7], 
  qsurv=quantsurv$question,
  place=1:length(condnames[[1]][1:7]),
  cond_set=rep(1:length(condnames[[1]][1:7]), each=max_cond, length.out=length(condnames[[1]][1:7])),
  max_cond=max_cond)
mtext(quantsurv$question, side=2, line=3)
xlab.height = min(matrix(unlist(boxplt[1,]), nrow=5)[1,])-6.4
spltlabs = lapply(strsplit(condnames[[1]][1:7], ' '), function(x) {
  if(length(x) > 3){
    starts = seq(1,(length(x)+1),3)
    ends = c(seq(starts[2],(length(x)+1),3)-1, length(x))
  } else { 
    starts = 1
    ends = length(x)
  }
  paste(lapply(1:length(starts), function(y) paste(c(x[starts[y]:ends[y]], '\n'), collapse=' ')), collapse=' ')
} )
text(x=1:length(condnames[[1]][1:7]), y=xlab.height, xpd=TRUE, labels=spltlabs, srt=0)