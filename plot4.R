# plot3 code

# Note about reading the data
# Using grep and wc in the command line, it was determined that the 
# required dates start in the row 66638 and comprise a total of 2880 rows.

#File names
datafile <- 'household_power_consumption.txt'
plotfile <- 'plot4.png'

# Read the data
electricity <- read.csv(datafile,
                        header=FALSE, sep = ";",
                        skip=66637,nrows=2880,                        
                        na.strings="?")
header <- read.csv(datafile,sep=";",na.strings="?",nrows=2)
names(electricity) <- names(header)

#Parse Dates and Times
electricity <- transform(electricity,Date=as.Date(electricity$Date,format = "%d/%m/%Y"))
electricity$DateTime <- paste(electricity$Date, electricity$Time)
electricity <- transform(electricity, 
                         DateTime = strptime(electricity$DateTime,
                                          format = "%Y-%m-%d %H:%M:%S"))

# Generate and save plot to PNG file
png(filename=plotfile,width=480,height=480,units="px")

# arrange as a 2 x 2 plots
par(mfrow=c(2,2))

# 1 plot - top left
plot(electricity$DateTime,electricity$Global_active_power,"l",     
     ylab="Global Active Power",
     xlab="")

# 2nd plot - top right
plot(electricity$DateTime,electricity$Voltage,"l",
     ylab="Voltage",
     xlab="datetime")

# 3rd plot -bottom left
plot(electricity$DateTime,electricity$Sub_metering_1,"l",
     ylab="Energy sub metering",xlab="")

ylims<-par("yaxp")[1:2] # get the y axis limits to pass to the next plots

par(new=T)
plot(electricity$DateTime,electricity$Sub_metering_2,"l", axes=FALSE,
     ylim=ylims, ylab="", xlab="", col="red")

par(new=T)
plot(electricity$DateTime,electricity$Sub_metering_3,"l", axes=FALSE,
     ylim=ylims, ylab="", xlab="", col="blue")

par(new=T)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=1, lty=1, col=c("black","red","blue"),bty="n",cex=0.8)

# 4th plot - bottom right
plot(electricity$DateTime,electricity$Global_reactive_power,"l",
     ylab="Global_reactive_power",
     xlab="datetime")

dev.off()
