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

# Create line plot for Sub_metering_1, Sub_metering_2, and Sub_metering_3
# Plot is created using a PNG file device
png(file = "plot3.png", width = 480, height = 480, units = "px")
with(df_subset, plot(DateTime, Global_active_power, type="n",
                     ylab = "Energy sub metering", xlab = "", ylim = c(0, 38)))
with(df_subset, lines(DateTime, Sub_metering_1, col = 'black'))
with(df_subset, lines(DateTime, Sub_metering_2, col = 'red'))
with(df_subset, lines(DateTime, Sub_metering_3, col = 'blue'))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2",
                                                               "Sub_metering_3"))
dev.off()