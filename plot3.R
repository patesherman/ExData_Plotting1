#Read file into R and set date format
dataset<-read.table("./household_power_consumption.txt", na.strings = "?", sep =";", header =TRUE)
dataset$Date<-as.Date(dataset$Date, format="%d/%m/%Y")

#Subset data for specific dates and connvert dates amd times
data <- dataset[(dataset$Date=="2007-02-01") | (dataset$Date=="2007-02-02"),]
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Create plot
with(data, plot(datetime, Sub_metering_1 , type = "l", col="black", ylab = "Energy sub metering", xlab=""))
lines(data$datetime, data$Sub_metering_2 , type = "l", col="red")
lines(data$datetime, data$Sub_metering_3 , type = "l", col="blue")
legend("topright", lty = 1, col= c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save plot to png
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
