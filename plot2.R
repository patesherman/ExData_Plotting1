#Read file into R and set date format
dataset<-read.table("./household_power_consumption.txt", na.strings = "?", sep =";", header =TRUE)
dataset$Date<-as.Date(dataset$Date, format="%d/%m/%Y")

#Subset data for specific dates and connvert dates amd times
data <- dataset[(dataset$Date=="2007-02-01") | (dataset$Date=="2007-02-02"),]
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Create plot
with(data, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab=""))

#Save plot to png
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()