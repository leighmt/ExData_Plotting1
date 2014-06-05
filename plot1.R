## Generate a bar chart of Global Active Power for the time period
## 2007-02-01 and 2007-02-02.

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
png(filename = "plot1.png", width = 480, height = 480)
with(graphdata,
     hist(as.numeric(Global_active_power),
          xlab = "Global Active Power (kilowatts)",
          main = "Global Active Power",
          col = "red")
)
dev.off()