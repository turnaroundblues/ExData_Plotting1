## This script assumes that 
##   1) the data is unzipped as "household_power_consumption.txt" and available in the working directory.
##   2) libraries dplyr and lubridate have been installed
##

library(dplyr)
library(lubridate)

datafile <- "household_power_consumption.txt"
datesused <- c("2007-02-01","2007-02-02")
plotfile <- "plot3.png"

## Read data
## convert date strings to POSIXct objects
## extract data subset for 2007-02-01 and 2007-02-02
## -----------------------------------------------------------------
data_all <- read.table(datafile, header = TRUE, stringsAsFactors = FALSE, na.strings="?",sep = ";")
data_all <- mutate(data_all, Date1 = dmy(Date))
data_all <- mutate(data_all, DateTime = dmy_hms(paste(Date,Time,sep=" ")))
data_used <- data_all[data_all$Date1 %in% ymd(datesused),]

#create the graph 
png(plotfile)

y1 <- data_used$Sub_metering_1
y2 <- data_used$Sub_metering_2
y3 <- data_used$Sub_metering_3
x <- data_used$DateTime

plot(x, y1, main = "", type = "l",
     ylab = "Energy sub metering",
     xlab = ""
     )
lines(x,y2, col = "red")
lines(x,y3, col = "blue")
legend("topright", legend = paste("Sub_metering_",c("1","2","3"),sep=""), 
       col = c("black", "red", "blue"), lwd = 1)
dev.off()


