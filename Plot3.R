library(dplyr)
library(ggplot2)
# Check whether the data file exists if not download the data file from the internet.
filename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(filename))
{
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file (fileurl, filename)  ## Download the dataset
}


if(!file.exists ("household_power_consumption.txt"))
{
    Unzip(filename) ## unzip the dataset
}
# read the data
datafile <- "./household_power_consumption.txt"
data <- read.table (datafile, header = TRUE, sep = ";", stringsAsFactor = FALSE, dec = ".")
# take the sub set of the data
subsetdata <- subset(data, data$Date == "1/2/2007"| data$Date == "2/2/2007")
# merge the date time data
datetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
# format and read data into individual variables
globalActivePower <- as.numeric(subsetdata$Global_active_power)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)
# create the png device file to create the plot 
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off() # close the device file
