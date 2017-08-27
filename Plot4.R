library(dplyr)
library(ggplot2)
# Check whether the data file exists if not download the data file from the internet.
filename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(filename))
{
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file (fileurl, filename) ## Download the dataset
}
    

if(!file.exists ("household_power_consumption.txt"))
   {
       Unzip(filename) ## unzip the dataset
}
datafile <- "./household_power_consumption.txt"
# read the data
data <- read.table (datafile, header = TRUE, sep = ";", stringsAsFactor = FALSE, dec = ".")
# take the sub set of the data
subsetdata <- subset(data, data$Date == "1/2/2007"| data$Date == "2/2/2007")
# merge the date time data
datetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
# format and read the data into individual variables
globalActivePower <- as.numeric(subsetdata$Global_active_power)
globalReactivePower <- as.numeric(subsetdata$Global_reactive_power)
voltage <- as.numeric(subsetdata$Voltage)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)
# prepare the device file ready for the plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off() # close the device file
