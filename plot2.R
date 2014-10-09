# plot2 code

# Note about reading the data
# Using grep and wc in the command line, it was determined that the 
# required dates start in the row 66638 and comprise a total of 2880 rows.

#File names
datafile <- 'household_power_consumption.txt'
plotfile <- 'plot2.png'

# Read the data
electricity <- read.csv(datafile,
                        header=FALSE, sep = ";",
                        skip=66637,nrows=2880,                        
                        na.strings="?")
header <- read.csv(datafile,sep=";",na.strings="?",nrows=2)
names(electricity) <- names(header)

# Parse Dates and Times
electricity <- transform(electricity, Date=as.Date(electricity$Date,format = "%d/%m/%Y"))
electricity$DateTime <- paste(electricity$Date, electricity$Time)
electricity <- transform(electricity,
                         DateTime = strptime(electricity$DateTime, 
                                          format = "%Y-%m-%d %H:%M:%S"))

# Generate and save plot to PNG file
png(filename=plotfile,width=480,height=480,units="px")

plot(electricity$DateTime,electricity$Global_active_power,"l",     
     ylab="Global Active Power (kilowatts)",
     xlab="")

dev.off()
