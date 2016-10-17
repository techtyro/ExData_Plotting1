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
png(filename = "plot1.png", width = 480, height = 480)
hist(proj_data$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
