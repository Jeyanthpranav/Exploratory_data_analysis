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

plot(finalData$SetTime, finalData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")