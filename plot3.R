# plot3.png

# Download and unzip dataset
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./eda_week1.zip")
unzip("eda_week1.zip", exdir = ".")

# Read table
dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Convert "Date" column to date class date class
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

# Make subset
data_subset <- subset(dataset, Date == "2007-02-01" | Date == "2007-02-02")

# Merge date and time values, and convert them to POSIXlt
timeline <- strptime(paste(data_subset$Date, data_subset$Time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC") 

# Convert three columns to numeric vertors
data_subset$Sub_metering_1 <- as.numeric(as.character(data_subset$Sub_metering_1))
data_subset$Sub_metering_2 <- as.numeric(as.character(data_subset$Sub_metering_2))
data_subset$Sub_metering_3 <- as.numeric(as.character(data_subset$Sub_metering_3))

# Plot data from Sub_metering_1
png() # Start PNG graphic device
with(data_subset, plot(timeline, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))

# Add data from next two columns
with(data_subset, lines(timeline, Sub_metering_2, type = "l", col = "red"))
with(data_subset, lines(timeline, Sub_metering_3, type = "l", col = "blue"))

# Add legend 
legend("topright", lty = c(1, 1, 1), cex = 0.9, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() # Close PNG graphic device