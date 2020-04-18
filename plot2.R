# Question: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland fips==24510 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
library(tidyverse)

NEI <- read_rds("summarySCC_PM25.rds")
SCC <- read_rds("Source_Classification_Code.rds")

baltimore.totals <- NEI %>%
        filter(fips == "24510") %>% # filter just Baltimore readings
        group_by(year) %>%
        summarize(total = sum(Emissions))

plot(baltimore.totals, ylab = "total PM2.5 emissions (tons)", main = "pm2.5 Emmissions in Baltimore City, MD", pch = 19)
with(baltimore.totals, text(year,total-100, labels = year))

# create plot
dev.copy(png,"plot2.png")
dev.off()
