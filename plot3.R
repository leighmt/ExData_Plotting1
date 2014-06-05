## Generate a line chart of each value for Energy Sub Metering
## for the time period 2007-02-01 and 2007-02-02.

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
png(filename = "plot3.png", width = 480, height = 480)
days <- with(graphdata,
             as.POSIXct(paste(as.Date(Date, format = "%d/%m/%Y"), Time)))
# Create graph using graphdata
with(graphdata, {
     # Initiate plot with first line
     plot(days,
          as.numeric(Sub_metering_1),
          type = "l",
          ylab = "Energy sub metering",
          xlab = "")
     # Add second line
     lines(days,
           as.numeric(Sub_metering_2),
           type = "l",
           col="red")
     # Add third line
     lines(days,
           as.numeric(Sub_metering_3),
           type = "l",
           col="blue")
})

# Set legend
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)
dev.off()