# Read data
dat = read.table('household_power_consumption.txt',header = T, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
da = subset(dat, dat$Date == '1/2/2007' | dat$Date == '2/2/2007')

da$Date <- as.Date(da$Date, format = "%d/%m/%Y")
da$DateTime = paste(da$Date, da$Time)
str(da$DateTime)
da$DateTime = strptime(da$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Plot 1
png("plot1.png", width=480, height=480)
plot1 = hist(da$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

# Plot 2
png("plot2.png", width=480, height=480)
with(da,plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()

# Plot 3
png("plot3.png", width=480, height=480)
with(da,plot(DateTime, da$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(da,lines(DateTime, Sub_metering_2, type="l", col="red"))
with(da,lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

# Plot 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(da$DateTime, da$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(da$DateTime, da$Voltage, type="l", xlab="datetime", ylab="Voltage")

with(da,plot(DateTime, da$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(da,lines(DateTime, Sub_metering_2, type="l", col="red"))
with(da,lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(da$DateTime, da$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
