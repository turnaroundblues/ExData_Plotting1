## This script assumes that 
##   1) the data is unzipped as "household_power_consumption.txt" and available in the working directory.
##   2) libraries dplyr and lubridate have been installed
##

library(dplyr)
library(lubridate)

datafile <- "household_power_consumption.txt"
datesused <- c("2007-02-01","2007-02-02")
plotfile <- "plot2.png"

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

y <- data_used$Global_active_power
x <- data_used$DateTime

plot(x, y, main = "", type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""
     )

dev.off()


