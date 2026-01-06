# commands to parse and interpret MTA ridership data 
# sources (recommend using Query to reduce data size before downloading):
#   https://data.ny.gov/Transportation/MTA-Daily-Ridership-and-Traffic-Beginning-2020/sayj-mze2/explore/query/SELECT%20%60date%60%2C%20%60mode%60%2C%20%60count%60%0AWHERE%0A%20%20caseless_one_of%28%60mode%60%2C%20%22MNR%22%29%0A%20%20AND%20%60date%60%0A%20%20%20%20%20%20%20%20BETWEEN%20%222025-01-06T12%3A49%3A32%22%20%3A%3A%20floating_timestamp%0A%20%20%20%20%20%20%20%20AND%20%222026-01-06T12%3A49%3A32%22%20%3A%3A%20floating_timestamp%0AORDER%20BY%20%60date%60%20DESC%20NULL%20FIRST/page/filter
#   https://metrics.mta.info/?ridership/daybydayridershipnumbers
#   https://data.ny.gov/browse?Dataset-Information_Agency=Metropolitan+Transportation+Authority&limitTo=datasets&sortBy=relevance&page=1&pageSize=20

# Data has columns for Date, Mode (here, already filtered for MNR), and Count (Ridership)

require(tidyverse)
require(lubridate)

# Turn the character date into an interpretable date by supplying the format it's using
date_formatted <- mdy(mnr$Date)
mnr <- mnr %>% mutate(Date_Formatted = date_formatted)

# extract the day of the week
mnr <- mnr %>% mutate(Day = wday(Date_Formatted)) # as a number from 1-7, 1=Sunday

DayName <- wday(mnr$Date_Formatted, label=TRUE) # as a 3-letter abbreviation
mnr <- mnr %>% mutate(DayName = DayName)

# find out which days are heaviest
day_summ <- mnr %>% 
  group_by(DayName) %>% 
  summarise(Mean = mean(Count),
            Median = median(Count))


# visualize

# compare mean and median
plot(x=day_summ$DayName, y=day_summ$Mean)
plot(x=day_summ$DayName, y=day_summ$Median)

# look at how each day has changed over the course of the time period
mnr_wed <- filter(mnr, DayName == "Wed")

mnr_mon <- filter(mnr, DayName == "Mon")
mnr_mon <- sort_by(mnr_mon, date_formatted)
plot(x=mnr_mon$Date_Formatted,y=mnr_mon$Count)

mnr_wed <- filter(mnr, DayName == "Wed")
mnr_wed <- sort_by(mnr_wed, date_formatted)
plot(x=mnr_wed$Date_Formatted,y=mnr_wed$Count)

# plot on the same Y axis
plot(x=mnr_wed$Date_Formatted,y=mnr_wed$Count, ylim = c(0,260000))
plot(x=mnr_mon$Date_Formatted,y=mnr_mon$Count, ylim = c(0,260000))

# look at the most recent half-year
# using an interval defined per the lubridate package
i <- interval(ymd("2025-07-01"), ymd("2026-01-06"))
mnr_latest <- filter(mnr, Date_Formatted %within% i)
mnr_latest_summ <- group_by(mnr_latest, DayName) %>% summarise(Mean = mean(Count), Median = median(Count))
plot(x=mnr_latest_summ$DayName, y=mnr_latest_summ$Median)
