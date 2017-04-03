# plot2.png

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

# Merge date and time values, and convert them to POSIXlt
timeline <- strptime(paste(data_subset$Date, data_subset$Time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC") 

# Build plot
png() # Open PNG graphic device
plot(timeline, data_subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off() # Close device