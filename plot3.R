# Question: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.
library(tidyverse)

NEI <- read_rds("summarySCC_PM25.rds")
SCC <- read_rds("Source_Classification_Code.rds")

baltimore.change <- NEI %>%
        filter(fips == "24510") %>% #filter just Baltimore readings
        group_by(type, year) %>%
        summarise(total = sum(Emissions)) %>%
        spread(key = year, value = total) %>%
        mutate(change = `2008` - `1999`)
        
baltimore.change %>%
        ggplot(aes(type, change)) +
        geom_col(aes(fill = change >0)) +
        scale_fill_manual(guide = FALSE, breaks = c(TRUE, FALSE), values = c("red3", "green3")) +
        coord_cartesian(ylim = c(-800, 200)) +
        labs(x = "Type", y = "Change in PM2.5 (tons) from 1999-2008", title = "Change in Emmissions in Baltimore City, MD")

# create plot
dev.copy(png,"plot3.png")
dev.off()
