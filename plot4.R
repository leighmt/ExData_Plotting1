## Generate a four graphs showing:
##   1. Global Active Power
##   2. Voltage
##   3. Energy sub metering
##   4. Global Reactive Power
##
## All graphs cover the period 2007-02-01 and 2007-02-02.

# Set location of archive
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
archive <- "data/exdata-data-household_power_consumption.zip"

# Check if data exists
if(!(file.exists("data"))) {
    dir.create("data")
}

# Download and unzip data if it doesn't already exist.
if(!(file.exists("data/household_power_consumption.txt"))) {
    download.file(url = url, destfile = archive, method = "curl", quiet = TRUE)
    unzip(archive, exdir="data/")
}

## Read household power consumption data
data <- read.csv("data/household_power_consumption.txt",
                 sep = ";",
                 colClasses = "character")

# Get subset of data required for assignment
graphdata <- subset(data, as.Date(Date, format = "%d/%m/%Y") >= '2007-02-01' &
                        as.Date(Date, format = "%d/%m/%Y") <= '2007-02-02')

# Generate PNG
png(filename = "plot4.png", width = 480, height = 480)
# Generate a list of days for graphing on x-axis
days <- with(graphdata,
             as.POSIXct(paste(as.Date(Date, format = "%d/%m/%Y"), Time)))
# Set parameters so that 4 graphs are generate 2 per line
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
with(graphdata, {
    # Generate 1st plot
    plot(days,
         Global_active_power,
         type = "l",
         ylab = "Global Active Power",
         xlab = "")
    # Generate 2nd plot
    plot(days,
         Voltage,
         type = "l",
         ylab = "Voltage",
         xlab = "datetime")
    # Generate 3rd plot
    plot(days,
         as.numeric(Sub_metering_1),
         type = "l",
         ylab = "Energy sub metering",
         xlab = "")
    # Add second line to 3rd plot
    lines(days,
          as.numeric(Sub_metering_2),
          type = "l",
          col="red")
    # Add third line to 3rd plot
    lines(days,
          as.numeric(Sub_metering_3),
          type = "l",
          col="blue")
    # Set legend for 3rd plot
    legend("topright",
           lty = 1,
           box.lwd = 0,
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    )
    # Generate 4th plot
    plot(days,
         Global_reactive_power,
         type = "l",
         ylab = "Global_reactive_power",
         xlab = "datetime")
})
dev.off()