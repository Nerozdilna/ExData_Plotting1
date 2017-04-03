# plot4.png

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

# Merge date and time values, and convert them to POSIXlt
timeline <- strptime(paste(data_subset$Date, data_subset$Time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

# Start PNG graphic device
png() 
# Split screen to fit 4 plots
par(mfrow = c(2, 2))

# Build first plot in first row
data_subset$Global_active_power <- as.numeric(as.character(data_subset$Global_active_power))  # convert data to numeric
plot(timeline, data_subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#Build second plot in the first row
data_subset$Voltage <- as.numeric(as.character(data_subset$Voltage)) # convert data to numeric
plot(timeline, data_subset$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Build first plot in the second row
# Convert three columns to numeric vertors
data_subset$Sub_metering_1 <- as.numeric(as.character(data_subset$Sub_metering_1))
data_subset$Sub_metering_2 <- as.numeric(as.character(data_subset$Sub_metering_2))
data_subset$Sub_metering_3 <- as.numeric(as.character(data_subset$Sub_metering_3))

# Plot data from Sub_metering_1
with(data_subset, plot(timeline, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))

# Add data from next two columns
with(data_subset, lines(timeline, Sub_metering_2, type = "l", col = "red"))
with(data_subset, lines(timeline, Sub_metering_3, type = "l", col = "blue"))

# Add legend 
legend("topright", lty = c(1, 1, 1), bty = "n", cex = 1.0, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Build second plot in the second row
data_subset$Global_reactive_power <- as.numeric(as.character(data_subset$Global_reactive_power)) 
plot(timeline, data_subset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off() # Close PGN graphic device