# Author: Brian Waismeyer
# Contact: bwaismeyer@gmail.com

# Date created: 2/8/2015
# Date updated: 

###############################################################################
## SCRIPT OVERVIEW
# goal: This script was created as part of the assignment describined in this
#       repository's README (https://github.com/bwaismeyer/ExData_Plotting1).

#       The script should acquire, load, and subset the provided "Electric
#       power consumption" data. Then it will reproduce "plot 4" and output
#       it as a PNG file.

# sketch of script
# - load any needed libraries

# - download file to working directory, unzip it, read it, and delete it
# - format the dates to a convenient datetime class
# - subset datafile to given time frame (data from the dates 2007-02-01 and 
#   2007-02-02)

# - use the base plotting system to recreate plot 4

# - print plot 4 to "plot4.png" via the relevant graphics device

###############################################################################
## LOAD LIBRARIES
library(lubridate)
library(dplyr)

###############################################################################
## ACQUIRE, FORMAT, AND SUBSET DATA

# file_url <- paste0("https://d396qusza40orc.cloudfront.net/",
#                    "exdata%2Fdata%2Fhousehold_power_consumption.zip")

# download file to working directory and unzip the contents into a unique folder
#download.file(file_url, "./project1.zip")
#unzip("./project1.zip", exdir = "./project1")

# read in the data
# NOTE: notice that stringsAsFactors was set to false - this prevents R from
#       reading the date and time columns as factors - we want the strings
#       for lubridate to convert
# power_data <- read.table("./project1/household_power_consumption.txt",
#                          sep = ";",
#                          na.strings = "?",
#                          header = TRUE,
#                          stringsAsFactors = FALSE)

# clean up downloaded and unzipped files
#unlink("./project1", recursive = TRUE)
#unlink("./project1.zip")

# format date column
#power_data <- tbl_df(power_data)
#power_data <- mutate(power_data, Date = dmy(Date))

# extract the data for 2007-02-01 and 2007-02-02
#power_subset <- filter(power_data, Date == dmy("1/2/2007") | Date == dmy("2/2/2007"))

###############################################################################
## DEFINE plot 4 FUNCTIONS (two new plots)
plot4a <- function() {
    power_subset$date_time <- paste(power_subset$Date, power_test$Time, sep = " ")
    power_subset <- mutate(power_subset, date_time = ymd_hms(date_time))
    
    with(power_subset, plot(Global_reactive_power ~ date_time, 
                            type = "l",
                            xlab = "")
    )
}

plot4b <- function() {
    with(power_subset, plot(Voltage ~ date_time, 
                            type = "l",
                            xlab = "datetime")
         )
}

###############################################################################
## DEFINE ALL THE EARLIER PLOT FUNCTIONS NEEDED TO CREATE THE 4-PART PLOT
# NOTE: minor tweaks to several of these earlier functions to match tweaks
#       observed in the assignment plot 4 itself (e.g., removed "main" title
#       in plot 1)

plot2 <- function() {
    power_subset$date_time <- paste(power_subset$Date, power_test$Time, sep = " ")
    power_subset <- mutate(power_subset, date_time = ymd_hms(date_time))
    
    with(power_subset, plot(Global_active_power ~ date_time, 
                            type = "l",
                            ylab = "Global Active Power (kilowatts)",
                            xlab = "")
    )
}

plot3 <- function() {
    power_subset$date_time <- paste(power_subset$Date, power_test$Time, sep = " ")
    power_subset <- mutate(power_subset, date_time = ymd_hms(date_time))
    
    with(power_subset, plot(Sub_metering_1 ~ date_time,
                            type = "l",
                            xlab = "datetime",
                            ylab = "Energy sub metering")
    )
    
    with(power_subset, lines(Sub_metering_2 ~ date_time,
                             col = "red")
    )
    
    with(power_subset, lines(Sub_metering_3 ~ date_time,
                             col = "blue")
    )
    
    legend("topright", 
           legend = c("Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3"),
           lty = c(1, 1, 1),
           col = c("black", "red", "blue")
    )
}

###############################################################################
## PRINT ALL FOUR PLOTS TO PNG (480 X 480 PIXELS)

# call PNG print device and set filename
png("./plot4.png")

# set global plot parameters to allow for all four plots
par(mfrow = c(2, 2))

# draw the four plots, noting that they will fill in row-wise
plot2()
plot3()
plot4()

# close the device
dev.off()

# reset the global plot parameters
par(mfrow = c(1, 1))
