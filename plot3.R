############
## PLOT 3 ##
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
data<- read.csv.sql(
    unzip("exdata_data_household_power_consumption.zip", # original zip file name
    "household_power_consumption.txt"), # reads the data 
    "select * from file where Date ='1/2/2007' or Date='2/2/2007'", # SQL statement to filter dates
    header = TRUE, sep = ";") # adds header and separator (no need to define decimal separator.)

# 3. Creating dataset 'data_3', with a combined "date.time" variable,
#### then selecting only the required variables. Requires libraries
#### 'lubridate' and 'dplyr'

library(lubridate)
library(dplyr)

data_3 <- data %>% # load the original dataset, THEN
    mutate(date.time = as.POSIXct(dmy_hms(paste(Date, Time)))) %>% # create a variable 'date.time' in POSIXct format, THEN
    select(date.time, Sub_metering_1, Sub_metering_2, Sub_metering_3) # select only the required variables

# 4. Creating PLOT 3: the call below does the entire work within the {}s:
#### a. Selects the dataset 'data_3'
#### b. Plots the 'Sub_metering_1' line and adds the labels
#### c. Adds the 'Sub_metering_2' red line
#### d. Adds the 'Sub_metering_3' blue line
#### e. Adds the legend at the top right corner

with(data_3, {
     plot(Sub_metering_1 ~ date.time, type="l", xlab="", ylab="Energy sub metering")
     lines(Sub_metering_2 ~ date.time, col="red")
     lines(Sub_metering_3 ~ date.time, col="blue")
     legend("topright", lty=1, lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  "), y.intersp=.95, x.intersp=.95, cex = .9, adj=.095)
})


# 5. Generating PNG image

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
