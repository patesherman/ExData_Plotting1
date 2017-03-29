#Read file into R and set date format
dataset<-read.table("./household_power_consumption.txt", na.strings = "?", sep =";", header =TRUE)
dataset$Date<-as.Date(dataset$Date, format="%d/%m/%Y")

#Subset data for specific dates and connvert dates amd times
data <- dataset[(dataset$Date=="2007-02-01") | (dataset$Date=="2007-02-02"),]
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Create plot
par(mfrow =c(2,2))
with (data,{
  plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab="")
  plot(datetime, Voltage, type = "l", ylab = "Voltage", xlab="datetime")
  plot(datetime, Sub_metering_1 , type = "l", col="black", ylab = "Energy sub metering", xlab="")
    lines(data$datetime, data$Sub_metering_2 , type = "l", col="red")
    lines(data$datetime, data$Sub_metering_3 , type = "l", col="blue")
    legend("topright",lty=1, col= c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  plot(datetime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="datetime")})
  
#Save plot to png
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()