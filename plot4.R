############
## PLOT 4 ##
############

############################################################
#### ATTENTION: IF YOU'D LIKE TO RUN THIS CODE IN YOUR  ####
#### MACHINE, MAKE SURE YOU HAVE ALL REQUIRED PACKAGES  #### 
############################################################

# 1. Getting the file

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "exdata_data_household_power_consumption.zip", mode = "wb")

# 2. Reading the data within the zip file, then
#### selecting desired rows using package 'sqldf'

library(sqldf)
data<- read.csv.sql(unzip("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"),
    "select * from file where Date ='1/2/2007' or Date='2/2/2007'", header = TRUE, sep = ";") 

# 3. Creating dataset 'data_4', selecting only the required variables. 
#### Requires libraries 'lubridate' and 'dplyr'

library(lubridate)
library(dplyr)

data_4 <- data %>% # load the original dataset, THEN
    mutate(date.time = as.POSIXct(dmy_hms(paste(Date, Time)))) %>% # create a variable 'date.time' in POSIXct format, THEN
    select(date.time, 3:9) # select desired variables

# 4. Creating PLOT 4: the call below does the entire work within the {}s:
#### a. Selects the dataset 'data_4'
#### b. Builds all plots

par(mfrow=c(2, 2))

with(data_4, {
    plot(Global_active_power ~ date.time, type = "l", xlab = "", ylab = "Global Active Power")
    plot(Voltage ~ date.time, type="l", xlab="datetime", ylab="Voltage" )
    {
    plot(Sub_metering_1 ~ date.time, type="l", xlab="", ylab="Energy sub metering")
    lines(Sub_metering_2 ~ date.time, col="red")
    lines(Sub_metering_3 ~ date.time, col="blue")
    }
    legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, cex=.95, y.intersp=.5, inset=c(.075,-.075), bty="n")
    plot(Global_reactive_power ~ date.time, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    })   
    

# 5. Generating PNG image

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
