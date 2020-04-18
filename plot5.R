# Question: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(tidyverse)

NEI <- read_rds("summarySCC_PM25.rds")
SCC <- read_rds("Source_Classification_Code.rds")

vehicleSCC <- SCC %>% 
        filter(str_detect(SCC.Level.Three, "Vehicle")) %>%
        select(SCC)

vehicle.totals <- NEI %>%
        filter(fips == "24510") %>% # filter just Baltimore readings
        filter(SCC %in% vehicleSCC$SCC) %>%
        group_by(year) %>%
        summarize(total = sum(Emissions))

vehicle.totals %>%
        ggplot(aes(year, total))+
        geom_point(size = 2) +
        labs(x = "Year", y = "PM2.5 Emmission (tons)", title = "Vehicle Related PM2.5 Emissions In Baltimore City, MD")

# create plot
dev.copy(png,"plot5.png")
dev.off()
