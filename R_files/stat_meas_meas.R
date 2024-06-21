## Handles analysis of multiple measurement data for each individual
# just need to flip the data format from long (one row for each data entry, i.e. 
# potentially many rows per person) to wide (one row for each individual)
# Issues: Some people have multiple of the same measurements

## For later:
# multi_meas = readline(prompt='How would you like to handle data for individuals with multiple of the same measurement? (enter a number: 1 = Average all measurements (default), 2 = Use most recent measurement, 3 = Use first (oldest) measurement, 4 = Use a random measurement)')

wide_measdat = reshape(measdata, idvar='person_id', timevar='standard_concept_name', direction = 'wide')

wide_measdat2 = na.omit(wide_measdat)
wide_measdat3 = wide_measdat2[!duplicated(wide_measdat2[,1]),]

correlation = cor(wide_measdat[,2:ncol(wide_measdat)])

print(correlation)
output <- capture.output(print(correlation))
writeLines(output, con=file('meas_meas_stat.csv'))
