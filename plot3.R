
#set working directory and download file
setwd("C://Users//Justin//Documents//temp")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "power.zip")

#read file
data <- read.table(unz("power.zip", "household_power_consumption.txt"),
                   header=T, quote="\"", sep=";")

#convert date filed to date and time field to time and subset
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")
data <- data[data$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")), ]
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")


#convert to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))


#create png, graph, and save
png(filename="C://Users//Justin//Documents//temp//plot3.png", width=480, height=480, units="px")

#add 3 lines with different colors
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(data, lines(DateTime, Sub_metering_2, col = "red" ))
with(data, lines(DateTime, Sub_metering_3, col = "blue" ))

#add legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        lty=1, col = c("black", "blue","Red"))

dev.off()