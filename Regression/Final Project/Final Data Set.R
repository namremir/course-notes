library(tidyverse)
library(viridis)
library(stringr)

freethrows <- read.csv("Free_Throws.csv")
playerinfo <- read.csv("Player_Stats.csv")

nbaplayers <- filter(playerinfo, `Stage` == "Regular_Season")

freethrowinfo <- left_join(freethrows,nbaplayers,by = c("player"="Player","season"="Season"))
freethrowfull <- filter(freethrowinfo, `Stage` == "Regular_Season")

freethrowstats <- subset(freethrowfull, select=-c(17,18,19,20))
freethrowstats <- mutate(freethrowstats,
                         FG_Pct = FGM/FGA,
                         X3_Pct = X3PM/X3PA,
                         FT_Pct = FTM/FTA,
                         age=as.numeric(substr(`season`,1,4))-`birth_year`,
                         playoff_dummy=ifelse(`playoffs`=="playoffs",1,0))

ggplot(freethrowstats) +
  geom_histogram(aes(x=seconds), bins=200)

ggplot(freethrowstats, aes(X3_Pct,FT_Pct)) +
  geom_point()
