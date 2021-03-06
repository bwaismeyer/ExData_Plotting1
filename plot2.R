# Author: Brian Waismeyer
# Contact: bwaismeyer@gmail.com

# Date created: 2/8/2015
# Date updated: 

###############################################################################
## SCRIPT OVERVIEW
# goal: This script was created as part of the assignment describined in this
#       repository's README (https://github.com/bwaismeyer/ExData_Plotting1).

#       The script should acquire, load, and subset the provided "Electric
#       power consumption" data. Then it will reproduce "plot 2" and output
#       it as a PNG file.

# sketch of script
# - load any needed libraries

# - download file to working directory, unzip it, read it, and delete it
# - format the dates to a convenient datetime class
# - subset datafile to given time frame (data from the dates 2007-02-01 and 
#   2007-02-02)

# - use the base plotting system to recreate plot 2

# - print plot 2 to "plot2.png" via the relevant graphics device

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
## DEFINE plot 2 FUNCTION
plot2 <- function() {
    power_subset$date_time <- paste(power_subset$Date, power_test$Time, sep = " ")
    power_subset <- mutate(power_subset, date_time = ymd_hms(date_time))
    
    with(power_subset, plot(Global_active_power ~ date_time, 
                            type = "l",
                            ylab = "Global Active Power (kilowatts)",
                            xlab = "")
    )
}

###############################################################################
## PRINT TO PNG (480 X 480 PIXELS)

# call PNG print device and set filename
png("./plot2.png")

# draw plot 2
plot2()

# close the device
dev.off()