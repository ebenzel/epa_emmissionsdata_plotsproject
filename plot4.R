# Question: Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?
library(tidyverse)

NEI <- read_rds("summarySCC_PM25.rds")
SCC <- read_rds("Source_Classification_Code.rds")

# select coal combusion-related sources by filtering SCC by EI.Sector that includes "Fuel Comb" and "Coal"
coalSCC <- SCC %>% 
        filter(str_detect(EI.Sector, "Coal$")) %>%
        select(SCC)

coal.totals <- NEI %>%
        filter(SCC %in% coalSCC$SCC) %>%
        group_by(year) %>%
        summarize(total = sum(Emissions))

coal.totals %>%
        ggplot(aes(as.factor(year),total))+
        geom_col() +
        labs(x = "Year", y = "PM2.5 Emmission (tons)", title = "Coal Combustion Related PM2.5 Emissions")

# create plot
dev.copy(png,"plot4.png")
dev.off()
