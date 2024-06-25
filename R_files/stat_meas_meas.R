## Handles analysis of multiple measurement data for each individual
# just need to flip the data format from long (one row for each data entry, i.e. 
# potentially many rows per person) to wide (one row for each individual)
# Issues: Some people have multiple of the same measurements

# change the measurement data from long (one row per person per datapoint) to wide (one row per person, one column per datapoint type)
wide_measdat = reshape(measdata, idvar='person_id', timevar='standard_concept_name', direction = 'wide')

# filter out rows that have na values (i.e. they don't have data for both kinds of data)
wide_measdat2 = na.omit(wide_measdat)

# eliminate duplicate data points for individuals (some people have gotten more than one measurement of a given type)
# by default, takes the most recent one
wide_measdat3 = wide_measdat2[!duplicated(wide_measdat2[,1]),]

# calculate the correlation of the measurements
correlation = cor(wide_measdat[,2:ncol(wide_measdat)])

# print out the correlation result
print(correlation)

# generate an output file
output <- capture.output(print(correlation))
writeLines(output, con=file('meas_meas_stat.csv'))
