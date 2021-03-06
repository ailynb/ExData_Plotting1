# ------------------------------------------------------------------------------
# CLEAN OBJECTS FROM WORKSPACE
# ------------------------------------------------------------------------------
rm(list=ls())


# ------------------------------------------------------------------------------
# WORKING DIRECTORY
# ------------------------------------------------------------------------------
setwd("")


# ------------------------------------------------------------------------------
# GET DATA
# ------------------------------------------------------------------------------
# - Download and Unzip Data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_name <- "household_power_consumption.zip"
if(!file.exists(file_name)){
    download.file(url, file_name)
    unzip(file_name)
}


# ------------------------------------------------------------------------------
# READ INPUT FILE
# ------------------------------------------------------------------------------
# - Read the "Individual household electric power consumption Data Set"
consumption <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?",
                          stringsAsFactors = FALSE)

## - Set time variable:only be using data from the dates 2007-02-01 and 2007-02-02
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007"),]
## - Add Column Date + Time
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time, sep=" "),"%d/%m/%Y %H:%M:%S")


# ------------------------------------------------------------------------------
# Generate PLOTS 
# Construct the plot and save it to a PNG file with a width of 480 pixels and a 
#   height of 480 pixels
# ------------------------------------------------------------------------------
# -- Generate PLOT 3
plot.new()
dev.copy(png,'plot3.png', width = 480, height = 480)
plot(consumption$DateTime, consumption$Sub_metering_1, type="l", col="black", xlab="", 
     ylab="Energy sub metering"
)
points(consumption[,c("DateTime","Sub_metering_2")], type="l", col="red")
points(consumption[,c("DateTime","Sub_metering_3")], type="l", col="blue")
legend("topright", lty="solid", col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)
dev.off()

