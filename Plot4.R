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

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

# plot 1 (NW)
plot(finalData$SetTime, finalData$Global_active_power, type = "l", ylab = "Global Active Power", 
    xlab = "")

# plot 2 (NE)
plot(finalData$SetTime, finalData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# plot 3 (SW)
plot(finalData$SetTime, finalData$Sub_metering_1, type = "l", ylab = "Energy sub metering", 
    xlab = "", col = "black")
points(finalData$SetTime, finalData$Sub_metering_2, type = "l", xlab = "", ylab = "Sub_metering_2", 
    col = "red")
points(finalData$SetTime, finalData$Sub_metering_3, type = "l", xlab = "", ylab = "Sub_metering_3", 
    col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", 
    "Sub_metering_2", "Sub_metering_3"), bty = "n", )

# plot 4 (SE)
plot(finalData$SetTime, finalData$Global_reactive_power, type = "l", xlab = "datetime", 
    ylab = "Global_reactive_power", ylim = c(0, 0.5))
	
dev.off()
