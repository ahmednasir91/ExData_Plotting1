# data.table is required for fread()
library(data.table)

# Download the file if it doesn't exist
if(!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", method = "curl", destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

# Load the data as a data frame
data <- fread("household_power_consumption.txt", sep = ";", na.strings="?")

# Change date column to Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subset to data of only 2007-02-01 and 2007-02-02
data <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

# Set the device to png file
png("figure/plot2.png")

# Transparent Background
par(bg = NA)

# Draw the plot
plot(as.POSIXct(paste(data$Date, data$Time)), data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", main = "", type="l")

# Turn off the device, to flush changes
dev.off()