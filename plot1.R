# Load dplyr library
library(dplyr)

# Read household power consumption data
df <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", 
                 header = TRUE, sep = ";", na.strings = "?")

# Create DateTime field using Date and Time fields
df <- transform(df, Date = as.character(Date), Time = as.character((Time)))
df <- df %>% mutate(DateTime = paste(Date, Time))
df$DateTime <- strptime(df$DateTime, format = "%d/%m/%Y %H:%M:%S")

t1 <- strptime("2007-02-01", format = "%Y-%m-%d")
t2 <- strptime("2007-02-03", format = "%Y-%m-%d")

# Subset data for "2007-02-01" and "2007-02-02"
df_subset = subset(df, DateTime > t1 & DateTime < t2)

# Create histogram and save the figure as Plot1.png
with(df_subset, hist(Global_active_power, main = "Global Active Power", col = 'red',
                     xlab = "Global Active Power (kilowatts)"))
dev.copy(png, file="plot1.png", width = 480, height = 480, unit = "px")
dev.off()