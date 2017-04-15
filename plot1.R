############
## PLOT 1 ##
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

# 3. Build Plot 1

with(data, 
     hist(Global_active_power, 
          main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)", 
          col = "Red"))

# 4. Export PNG file 

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
