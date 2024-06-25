 
# Set working directory to the root for the R files
# We have to do this because master.R in the root directory pulls scripts from that directory, 
# but changing directories in R is an extra step we don't want to worry about.

if('./R_files' %in% list.dirs(recursive=TRUE)) setwd('/home/rstudio/AOU_R/R_files')

source('master.R')
