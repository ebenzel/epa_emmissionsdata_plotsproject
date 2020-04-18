# Question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

library(tidyverse)

NEI <- read_rds("summarySCC_PM25.rds")
SCC <- read_rds("Source_Classification_Code.rds")

totals <- NEI %>%
        group_by(year) %>%
        summarize(total = sum(Emissions)/10^6)

plot(totals, ylab = "total PM2.5 emissions (million tons)", pch = 19)
with(totals, text(year,total-.25, labels = year))

# create plot
dev.copy(png,"plot1.png")
dev.off()
