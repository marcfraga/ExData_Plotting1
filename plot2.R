############
## PLOT 2 ##
############

############################################################
#### ATTENTION: IF YOU'D LIKE TO RUN THIS CODE IN YOUR  ####
#### MACHINE, MAKE SURE YOU HAVE ALL REQUIRED PACKAGES  #### 
############################################################

# 1. Getting the file

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "exdata_data_household_power_consumption.zip", mode = "wb")

# 2. Reading the file within the zip file, then
#### selecting desired rows using package 'sqldf'

library(sqldf)
data<- read.csv.sql(
    unzip("exdata_data_household_power_consumption.zip", # original zip file name
          "household_power_consumption.txt"), # reads the data 
    "select * from file where Date ='1/2/2007' or Date='2/2/2007'", # SQL statement to filter dates
    header = TRUE, sep = ";") # adds header and separator (no need to define decimal separator.)

# 3. Creating dataset 'data_2', with a combined "date.time" variable,
#### then selecting only the required variables. Requires libraries
#### 'lubridate' and 'dplyr'

library(lubridate)
library(dplyr)

data_2 <- data %>% # load the original dataset, THEN
    mutate(date.time = as.POSIXct(dmy_hms(paste(Date, Time)))) %>% # create a variable 'date.time' in POSIXct format, THEN
    select(date.time, Global_active_power) # select only the required variables (date.time & Global_active_power)

# 4. Creating PLOT #2

with(data_2, # Requesting dataset
     plot(date.time, Global_active_power, # choosing variables to plot
          type = "l", # Selecting a line graph
          xlab = "", # blank X-axis label 
          ylab = "Global Active Power (kilowatts)")) # Y-axis label

# 5. Generating PNG image

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
