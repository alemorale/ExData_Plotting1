# plot1 code

# Note about reading the data
# Using grep and wc in the command line, it was determined that the 
# required dates start in the row 66638 and comprise a total of 2880 rows.

#File names
datafile <- 'household_power_consumption.txt'
plotfile <- 'plot1.png'

# Download and unzip the data
zipfile <- 'household_power_consumption.zip'
if(!file.exists('household_power_consumption.zip')){    
    fileURL<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(url = fileURL, 
                  destfile = zipfile,
                  method = 'curl')
    unzip(zipfile)
}

# Read the data
electricity <- read.csv(datafile,
                        header=FALSE, sep = ";",
                        skip=66637,nrows=2880,                        
                        na.strings="?")
header <- read.csv(datafile,sep=";",na.strings="?",nrows=2)
names(electricity) <- names(header)

#Parse Dates and Times
electricity <- transform(electricity, Date=as.Date(electricity$Date,format = "%d/%m/%Y"))
electricity$Datetime <- paste(electricity$Date, electricity$Time)
electricity <- transform(electricity, 
                         Datetime = strptime(electricity$Datetime,
                                          format = "%Y-%m-%d %H:%M:%S"))

# Generate and save plot to PNG file
png(filename=plotfile,width=480,height=480,units="px")

hist(electricity$Global_active_power, 
     col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power")

dev.off()
