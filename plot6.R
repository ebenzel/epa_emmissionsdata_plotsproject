# Question: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California fips=="06037". Which city has seen greater changes 
# over time in motor vehicle emissions?
library(tidyverse)

NEI <- read_rds("summarySCC_PM25.rds")
SCC <- read_rds("Source_Classification_Code.rds")

vehicleSCC <- SCC %>% 
        filter(str_detect(SCC.Level.Three, "Vehicle")) %>%
        select(SCC)

vehicle.totals <- NEI %>%
        filter(fips %in% c("24510", "06037")) %>% # filter Baltimore and LA
        filter(SCC %in% vehicleSCC$SCC) %>%
        group_by(fips,year) %>%
        summarize(total = sum(Emissions)) %>%
        spread(key = year, value = total) %>%
        mutate(change2002 = `2002` - `1999`) %>%
        mutate(change2005 = `2005` - `1999`) %>%
        mutate(change2008 = `2008` - `1999`) %>%
        select(-c(`1999`,`2002`,`2005`,`2008`))

names(vehicle.totals)[2:4] <- c("2002", "2005", "2008")

vehicle.changes <- gather(vehicle.totals,"year","change",2:4)
                             
vehicle.changes %>%
        ggplot(aes(x = year, y = change, color = fips)) +
        geom_point(size = 2) +
        labs(x = "Year", 
             y = "Change in PM2.5 Emmission (tons) since 1999", 
             title = "Change in Vehicle Emmissions") +
        scale_color_discrete(name = "Location", breaks = c("06037", "24510"), labels = c("Los Angeles, CA", "Baltimore City, MD"))


# create plot
dev.copy(png,"plot6.png")
dev.off()
