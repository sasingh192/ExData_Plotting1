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

# Create 2x2 plots on a PNG graphic device
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2), mar = c(1,1,1,1), mai = c(1, 0.75, 0.1, 0.1))
# Plot Global_active_power
with(df_subset, plot(DateTime, Global_active_power, type="n",
                     ylab = "Global_active_power (kilowatts)", xlab = ""))
with(df_subset, lines(DateTime, Global_active_power))
# Plot Voltage
with(df_subset, plot(DateTime, Voltage, type="n",
                     ylab = "Voltage"))
with(df_subset, lines(DateTime, Voltage))
# Create line plot for Sub_metering_1, Sub_metering_2, and Sub_metering_3
# png(file = "plot3.png", width = 480, height = 480, units = "px")
with(df_subset, plot(DateTime, Global_active_power, type="n",
                     ylab = "Energy sub metering", xlab = "", ylim = c(0, 38)))
with(df_subset, lines(DateTime, Sub_metering_1, col = 'black'))
with(df_subset, lines(DateTime, Sub_metering_2, col = 'red'))
with(df_subset, lines(DateTime, Sub_metering_3, col = 'blue'))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2",
                                                                        "Sub_metering_3"))
# Global_reactive_power
with(df_subset, plot(DateTime, Global_reactive_power, type="n",
                     ylab = "Global_reactive_power"))
with(df_subset, lines(DateTime, Global_reactive_power))
# Close PNG graphic device
dev.off()
