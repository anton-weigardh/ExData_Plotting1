## File: plot3.R
## Author: Weigardh, A
##
## This script reconstructs a figure.
## The figure is saved as "plot3.png" with the size 480*480 pixels.
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
  ## Variables: Sub_metering_1, Sub_metering_2 & Sub_metering_3

png(filename = "plot3.png", width = 480, height = 480, type = "cairo" )
plot(data[["Sub_metering_1"]], ylab = "Energy sub metering", xlab = "", type = "l", xaxt = "n")
  
  ## Adding additonal lines
lines(data[["Sub_metering_2"]], col="red")
lines(data[["Sub_metering_3"]], col="blue")
  
  ## Fixing axis and legend
axis(1, c(1,length(data[["Sub_metering_1"]])/2, length(data[["Sub_metering_1"]])), c("Thu","Fri","Sat"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, cex = 0.9)
dev.off()