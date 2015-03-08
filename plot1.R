## This script assumes that 
##   1) the data is unzipped as "household_power_consumption.txt" and available in the working directory.
##   2) libraries dplyr and lubridate have been installed
##

library(dplyr)
library(lubridate)

datafile <- "household_power_consumption.txt"
plotfile <- "plot1.png"

## Read data
## convert date strings to POSIXct objects
## extract data subset for 2007-02-01 and 2007-02-02
## -----------------------------------------------------------------
data_all <- read.table(datafile, header = TRUE, stringsAsFactors = FALSE, na.strings="?",sep = ";")
data_all <- mutate(data_all, Date = dmy(Date))
datesused <- ymd(c("2007-02-01","2007-02-02"))
data_used <- data_all[data_all$Date %in% datesused,]

#create the graph 
png(plotfile)

x <- data_used$Global_active_power
hist(x, main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)", 
        col = "red", 
        ylim = c(0,1200))

dev.off()


