setwd("~/coursera/exploratory/ExData_Plotting1")
if (!file.exists("data")){
    dir.create("data")
}

if ( !file.exists("./data/household_power_consumption.txt")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile="./data/powerConsumption.zip", method="curl")
    unzip( zipfile="./data/powerConsumption.zip", exdir="./data")
}

data <- read.csv(file="./data/household_power_consumption.txt",sep = ";",header=TRUE,na.strings="?",)
data <- within(data, Datetime <- as.POSIXlt(paste(Date, Time),
                                          format = "%d/%m/%Y %H:%M:%S"))
plotdata <- data[data$Datetime>="2007-02-01 00:00:00" & data$Datetime<="2007-02-02 23:59:59",]
for (col in 3:8) set(data, j=col, value=as.numeric(data[[col]]))

png("plot2.png", width = 480, height=480)
plot(x = plotdata$Datetime, y=plotdata$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
