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
png("figure/plot4.png")

# Transparent Background and 2x2 Plots
par(mfrow = c(2, 2), bg = NA)

# Date for x-axis
x <- as.POSIXct(paste(data$Date, data$Time))

# Plot 1
plot(x, data$Global_active_power, xlab="", ylab="Global Active Power", main = "", type="l")

# Plot 2
plot(x, data$Voltage, xlab="datetime", ylab="Voltage", main = "", type="l")

# Plot 3
plot(x, data$Sub_metering_1, xlab="", ylab="Energy sub metering", main = "", type="n")
lines(x, data$Sub_metering_1, type="l")

lines(x, data$Sub_metering_2, type="l", col = "red")

lines(x, data$Sub_metering_3, type="l", col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "red", "blue"))

# Plot 4
plot(x, data$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", main = "", type="l")

# Turn off the device, to flush changes
dev.off()