# plot1.png

# Download and unzip dataset
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./eda_week1.zip")
unzip("eda_week1.zip", exdir = ".")

# Read table
dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Convert "Date" column to date class
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

# Make subset
data_subset <- subset(dataset, Date == "2007-02-01" | Date == "2007-02-02")

# Convert "Global Active Power" row from factor to numeric
data_subset$Global_active_power <- as.numeric(as.character(data_subset$Global_active_power))

# Build histogram
png() # Open PNG graphic device
hist(data_subset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", breaks = 12)
dev.off() # Close graphic device
# Note: Values larger than 5.5 (4 records out of 2880 in total) are not reflected on histogram. To view them, "breaks" argument should be increased (say, to 150)