## File: plot2.R
## Author: Weigardh, A
##
## This script reconstructs a figure.
## The figure is saved as "plot2.png" with the size 480*480 pixels.
##
## In order to run the script, the file household_power_consumption.txt must be in the working directory.
## It can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## The script will try to download the data if the file does not exists.
##
## We have two days of interest 
## 01/02/2007 and 02/02/2007
## One observation is made each minute.
## Thus 2880 observations of interest.
##
##--------------------------------------------------------------------#
## Import Appropriate Data

  ## Download and Unzip the data if needed
if (!file.exists("household_power_consumption.txt")){
  message("Downloading data")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","exdata-data-household_power_consumption.zip")
  unzip("exdata-data-household_power_consumption.zip")
}

  ## Import the first rows of the data set.
firstRows<- read.table("household_power_consumption.txt", sep = ";", nrow = 1, header = TRUE)

  ## Extract the first observation date
firstObs <- paste(as.character(firstRows[[1,1]]),as.character(firstRows[[1,2]]), sep = " ")

  ## Calculate difference between first observation and 01/02/2007
diff <- (as.numeric(strptime(c("01/02/2007 00:01:00"), format = "%d/%m/%Y %H:%M:%S")-strptime(c(firstObs[1]), format = "%d/%m/%Y %H:%M:%S")))*1440

  ## Read only the wanted data to save time. Start at 01/02/2007. End 48 hours later. 
data <- read.table("household_power_consumption.txt", sep = ";", skip = diff, nrow = 2880)

  ## Set Labels
colnames(data) <- names(firstRows)

##--------------------------------------------------------------------#
## Generate Figure
  ## Type: Plot
  ## Variable: Global Active Power

png(filename = "plot2.png", width = 480, height = 480, type = "cairo")
plot(data[["Global_active_power"]], ylab = "Global Active Power (kilowatts)", xlab = "", type = "l", xaxt = "n")

  ## Set the appropriate ticks in x-axis.
axis(1, c(1,length(data[["Global_active_power"]])/2, length(data[["Global_active_power"]])), c("Thu","Fri","Sat"))
dev.off()