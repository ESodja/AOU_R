### Plots for measurements for a given condition; may generate several plots
max_cond = 7
png('plot_cnd_meas.png', width=1200, height=800)
boxplt <- mapply(function(cond, meas, place, cond_set, max_cond) {
  place.adj <- place %% max_cond
  if(place %% max_cond == 1) {
    add.me = FALSE
  } else { 
    add.me = TRUE 
    if (place %% max_cond == 0) place.adj <- max_cond
  }
  ylms = range(as.numeric(cond_meas[cond_meas$standard_concept_name.y == meas & cond_meas$standard_concept_name.x %in% condnames[[1]][c(1,2,3,5,7,11,13)],"value_as_number"]))
  print(ylms)
  print(add.me)
  bp <- boxplot(as.formula('as.numeric(value_as_number) ~ standard_concept_name.x'), 
          data=cond_meas[cond_meas$standard_concept_name.y == meas & is.finite(as.numeric(cond_meas$value_as_number)) & cond_meas$standard_concept_name.x %in% cond,],
          add=add.me,
          at=place.adj,
          xlims=c(0.5,max_cond+0.5),
          ylab='',
          xlab='',
          names=cond,
          range=0,
          ylimx=ylms)
  return(bp)
  }, 
  cond=condnames[[1]][c(1,2,3,5,7,11,13)], 
  meas=meastypes[[1]],
  place=1:length(condnames[[1]][c(1,2,3,5,7,11,13)]),
  cond_set=rep(1:length(condnames[[1]][c(1,2,3,5,7,11,13)]), each=max_cond, length.out=length(condnames[[1]][c(1,2,3,5,7,11,13)])),
  max_cond=max_cond)
mtext(meastypes[[1]], side=2, line=3)
xlab.height = min(matrix(unlist(boxplt[1,]), nrow=5)[1,])-5.4
spltlabs = lapply(strsplit(condnames[[1]][c(1,2,3,5,7,11,13)], ' '), function(x) {
  if(length(x) > 3){
    starts = seq(1,(length(x)+1),3)
    ends = c(seq(starts[2],(length(x)+1),3)-1, length(x))
  } else { 
    starts = 1
    ends = length(x)
  }
  paste(lapply(1:length(starts), function(y) paste(c(x[starts[y]:ends[y]], '\n'), collapse=' ')), collapse=' ')
} )
text(x=1:length(condnames[[1]][c(1,2,3,5,7,11,13)]), y=xlab.height, xpd=TRUE, labels=spltlabs, srt=0)
dev.off()