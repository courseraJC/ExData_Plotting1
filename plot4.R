setwd("~/coursera/exploratory/ExData_Plotting1")
if (!file.exists("data")){
    dir.create("data")
}

if ( !file.exists("./data/household_power_consumption.txt")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile="./data/powerConsumption.zip", method="curl")
    unzip( zipfile="./data/powerConsumption.zip", exdir="./data")
}

library(ggplot2)
data <- read.csv(file="./data/household_power_consumption.txt",sep = ";",header=TRUE,na.strings="?",)
data <- within(data, Datetime <- as.POSIXlt(paste(Date, Time),
                                          format = "%d/%m/%Y %H:%M:%S"))
plotdata <- data[data$Datetime>="2007-02-01 00:00:00" & data$Datetime<="2007-02-02 23:59:59",]
for (col in 3:8) set(data, j=col, value=as.numeric(data[[col]]))

png("plot4.png", width = 480, height=480)
par(mfrow=c(2,2))

plot(x = plotdata$Datetime, y=plotdata$Global_active_power, type = "l", ylab="Global Active Power", xlab="")

plot(x = plotdata$Datetime, y=plotdata$Voltage, type = "l", ylab="Voltage", xlab="datetime")


plot(x = plotdata$Datetime, y=plotdata$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="", main="")
lines(x = plotdata$Datetime, y=plotdata$Sub_metering_2, col="red", type = "l", ylab="Energy sub metering", xlab="")
lines(x = plotdata$Datetime, y=plotdata$Sub_metering_3, col="blue", type = "l", ylab="Energy sub metering", xlab="")
legend( "topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty = "n")

plot(x = plotdata$Datetime, y=plotdata$Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
