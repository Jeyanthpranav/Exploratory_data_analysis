library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists('household_power_consumption.zip')){
   #Downloads input data set 
    download.file(url,destfile="household_power_consumption.zip",mode = "wb")
  
}

filePath<-paste(getwd(),"/household_power_consumption/household_power_consumption.txt",sep="")
plotData <- fread(filePath,sep=";",nrows = -1, na.strings = "?",stringsAsFactors=FALSE) 
finalData <- plotData[plotData$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
finalData <- cbind(SetTime, finalData)

plot(finalData$SetTime, finalData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(finalData$SetTime, finalData$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", 
    col = "red")
points(finalData$SetTime, finalData$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", 
    col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", 
    "Sub_metering_2", "Sub_metering_3"))