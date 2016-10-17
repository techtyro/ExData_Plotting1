#Check for the data file
if(!file.exists("household_power_consumption.txt"))
    stop("DATA FILE NOT FOUND! copy the file household_power_consumption.txt to your working directory")

#Read data
proj_data <- read.table("household_power_consumption.txt", header = T, sep=";", na.strings = "?")

#Filter and add datetime
require(lubridate)
require(dplyr)
proj_data <- proj_data %>%
    filter(grepl("^(1/2/2007|2/2/2007)", proj_data$Date)) %>% 
    mutate(datetime=dmy_hms(paste(Date, Time)))

#Create plot in png
png(filename = "plot3.png", width = 480, height = 480)

plot(proj_data$datetime, proj_data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

points(proj_data$datetime, proj_data$Sub_metering_1, col="black", type="l")
points(proj_data$datetime, proj_data$Sub_metering_2, col="red", type="l")
points(proj_data$datetime, proj_data$Sub_metering_3, col="blue", type="l")

legend("topright", col=c("black", "red", "blue"), legend = names(proj_data)[(ncol(proj_data)-3):(ncol(proj_data)-1)], lty = 1)

dev.off()