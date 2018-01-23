
library(dplyr)
##Download and load file into data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv2(unz(temp, "household_power_consumption.txt"),header=TRUE, stringsAsFactors = FALSE)

unlink(temp)

##Clean data : the clean dataset is named Input3
data%>%mutate(Date=as.Date(Date,format="%d/%m/%Y"),
              DTime=as.POSIXct(paste(Date,Time), format="%Y-%m-%d %H:%M:%S"))->Input


Input[Input$Date>="2007-02-01"& Input$Date <="2007-02-02",]->Input2
Input2%>%mutate(Global_active_power=as.numeric(Global_active_power),
                Global_reactive_power=as.numeric(Global_reactive_power),
                Voltage=as.numeric(Voltage),
                Global_intensity=as.numeric(Global_intensity),
                Sub_metering_1=as.numeric(Sub_metering_1),
                Sub_metering_2=as.numeric(Sub_metering_2),
                Sub_metering_3=as.numeric(Sub_metering_3))->Input3

##Plot
png(filename = "plot2.png",width = 480, height = 480, units = "px")
par(mfrow=c(1,1))
with(Input3,plot(DTime,Global_active_power,
                 ylab = "Global Active Power (kilowatts)",type="l"))
dev.off()
