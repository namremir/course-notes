library(tidyverse)
library(viridis)

full <- read_csv("IMDb movies.csv")
votes <- read_csv("IMDb ratings.csv")

fullvotes <- full_join(full, votes, by = "imdb_title_id")
filtvotes <- filter(fullvotes, `total_votes` >= 10000)
filtvotes <- filter(filtvotes, `year` >= 1925)

mutvotes <- mutate(filtvotes, action = str_detect(`genre`,"Action"),
                   adventure = str_detect(`genre`,"Adventure"),
                   comedy = str_detect(`genre`,"Comedy"),
                   crime = str_detect(`genre`,"Crime"),
                   drama = str_detect(`genre`,"Drama"),
                   fantasy = str_detect(`genre`,"Fantasy"),
                   historical = str_detect(`genre`,"History"),
                   horror = str_detect(`genre`,"Horror"),
                   mystery = str_detect(`genre`,"Mystery"),
                   romance = str_detect(`genre`,"Romance"),
                   thriller = str_detect(`genre`,"Thriller"),
                   western = str_detect(`genre`,"Western"),
                   scifi = str_detect(`genre`,"Sci-Fi"))

mutvotes$year[is.na(mutvotes$year)] <- 2019

relvotes <- summarize(group_by(mutvotes, year),
                      act_med = median(`mean_vote`[`action`==T],na.rm=T),
                      adv_med = median(`mean_vote`[`adventure`==T],na.rm=T),
                      com_med = median(`mean_vote`[`comedy`==T],na.rm=T),
                      cri_med = median(`mean_vote`[`crime`==T],na.rm=T),
                      dra_med = median(`mean_vote`[`drama`==T],na.rm=T),
                      fan_med = median(`mean_vote`[`fantasy`==T],na.rm=T),
                      his_med = median(`mean_vote`[`historical`==T],na.rm=T),
                      hor_med = median(`mean_vote`[`horror`==T],na.rm=T),
                      mys_med = median(`mean_vote`[`mystery`==T],na.rm=T),
                      rom_med = median(`mean_vote`[`romance`==T],na.rm=T),
                      thr_med = median(`mean_vote`[`thriller`==T],na.rm=T),
                      wes_med = median(`mean_vote`[`western`==T],na.rm=T),
                      sci_med = median(`mean_vote`[`scifi`==T],na.rm=T),
                      act_q1 = quantile(`mean_vote`[`action`==T],0.25,na.rm=T),
                      adv_q1 = quantile(`mean_vote`[`adventure`==T],0.25,na.rm=T),
                      com_q1 = quantile(`mean_vote`[`comedy`==T],0.25,na.rm=T),
                      cri_q1 = quantile(`mean_vote`[`crime`==T],0.25,na.rm=T),
                      dra_q1 = quantile(`mean_vote`[`drama`==T],0.25,na.rm=T),
                      fan_q1 = quantile(`mean_vote`[`fantasy`==T],0.25,na.rm=T),
                      his_q1 = quantile(`mean_vote`[`historical`==T],0.25,na.rm=T),
                      hor_q1 = quantile(`mean_vote`[`horror`==T],0.25,na.rm=T),
                      mys_q1 = quantile(`mean_vote`[`mystery`==T],0.25,na.rm=T),
                      rom_q1 = quantile(`mean_vote`[`romance`==T],0.25,na.rm=T),
                      thr_q1 = quantile(`mean_vote`[`thriller`==T],0.25,na.rm=T),
                      wes_q1 = quantile(`mean_vote`[`western`==T],0.25,na.rm=T),
                      sci_q1 = quantile(`mean_vote`[`scifi`==T],0.25,na.rm=T),
                      act_q3 = quantile(`mean_vote`[`action`==T],0.75,na.rm=T),
                      adv_q3 = quantile(`mean_vote`[`adventure`==T],0.75,na.rm=T),
                      com_q3 = quantile(`mean_vote`[`comedy`==T],0.75,na.rm=T),
                      cri_q3 = quantile(`mean_vote`[`crime`==T],0.75,na.rm=T),
                      dra_q3 = quantile(`mean_vote`[`drama`==T],0.75,na.rm=T),
                      fan_q3 = quantile(`mean_vote`[`fantasy`==T],0.75,na.rm=T),
                      his_q3 = quantile(`mean_vote`[`historical`==T],0.75,na.rm=T),
                      hor_q3 = quantile(`mean_vote`[`horror`==T],0.75,na.rm=T),
                      mys_q3 = quantile(`mean_vote`[`mystery`==T],0.75,na.rm=T),
                      rom_q3 = quantile(`mean_vote`[`romance`==T],0.75,na.rm=T),
                      thr_q3 = quantile(`mean_vote`[`thriller`==T],0.75,na.rm=T),
                      wes_q3 = quantile(`mean_vote`[`western`==T],0.75,na.rm=T),
                      sci_q3 = quantile(`mean_vote`[`scifi`==T],0.75,na.rm=T)
                      )

relvotes_med <- gather(relvotes, key="Genre", value="Median", -c(year,act_q1,adv_q1,com_q1,cri_q1,
                                                                      dra_q1,fan_q1,his_q1,hor_q1,
                                                                      mys_q1,rom_q1,thr_q1,wes_q1,
                                                                      sci_q1,act_q3,adv_q3,com_q3,
                                                                      cri_q3,dra_q3,fan_q3,his_q3,
                                                                      hor_q3,mys_q3,rom_q3,thr_q3,
                                                                      wes_q3,sci_q3
                                                                 ))
relvotes_med$index <- 1:nrow(relvotes_med)
relvotes_med$Genre[relvotes_med$Genre == "act_med"] <- "Action"
relvotes_med$Genre[relvotes_med$Genre == "adv_med"] <- "Adventure"
relvotes_med$Genre[relvotes_med$Genre == "com_med"] <- "Comedy"
relvotes_med$Genre[relvotes_med$Genre == "cri_med"] <- "Crime"
relvotes_med$Genre[relvotes_med$Genre == "dra_med"] <- "Drama"
relvotes_med$Genre[relvotes_med$Genre == "fan_med"] <- "Fantasy"
relvotes_med$Genre[relvotes_med$Genre == "his_med"] <- "Historical"
relvotes_med$Genre[relvotes_med$Genre == "hor_med"] <- "Horror"
relvotes_med$Genre[relvotes_med$Genre == "mys_med"] <- "Mystery"
relvotes_med$Genre[relvotes_med$Genre == "rom_med"] <- "Romance"
relvotes_med$Genre[relvotes_med$Genre == "thr_med"] <- "Thriller"
relvotes_med$Genre[relvotes_med$Genre == "wes_med"] <- "Western"
relvotes_med$Genre[relvotes_med$Genre == "sci_med"] <- "Scifi"

relvotes_q1 <- gather(relvotes, key="Genre", value="Q1", -c(year,act_med,adv_med,com_med,cri_med,
                                                                 dra_med,fan_med,his_med,hor_med,
                                                                 mys_med,rom_med,thr_med,wes_med,
                                                                 sci_med,act_q3,adv_q3,com_q3,
                                                                 cri_q3,dra_q3,fan_q3,his_q3,
                                                                 hor_q3,mys_q3,rom_q3,thr_q3,
                                                                 wes_q3,sci_q3
                                                                 ))
relvotes_q1$index <- 1:nrow(relvotes_q1)

relvotes_q3 <- gather(relvotes, key="Genre", value="Q3", -c(year,act_med,adv_med,com_med,cri_med,
                                                                dra_med,fan_med,his_med,hor_med,
                                                                mys_med,rom_med,thr_med,wes_med,
                                                                sci_med,act_q1,adv_q1,com_q1,
                                                                cri_q1,dra_q1,fan_q1,his_q1,
                                                                hor_q1,mys_q1,rom_q1,thr_q1,
                                                                wes_q1,sci_q1
                                                                ))
relvotes_q3$index <- 1:nrow(relvotes_q3)


relvotes_gathered <- full_join(relvotes_med, relvotes_q1, by = "index")
relvotes_gathered <- full_join(relvotes_gathered, relvotes_q3, by = "index")
relvotes_gathered <- subset(relvotes_gathered, select=c("year.x","Genre.x","Median","Q1","Q3"))
names(relvotes_gathered)[names(relvotes_gathered) == "year.x"] <- "year"
names(relvotes_gathered)[names(relvotes_gathered) == "Genre.x"] <- "genre"
rm(relvotes_med, relvotes_q1, relvotes_q3, fullvotes)

avgvotes <- summarize(group_by(mutvotes, year),
                      med = median(`mean_vote`,na.rm=T),
                      q1 = quantile(`mean_vote`,0.25,na.rm=T),
                      q3 = quantile(`mean_vote`,0.75,na.rm=T),
                      )

avgvotes <- mutate(avgvotes, genre = "All")
names(avgvotes) <- c("year","Median","Q1","Q3", "genre")
avgvotes <- avgvotes[, c(1,5,2,3,4)]

genvotes <- rbind(relvotes_gathered, avgvotes)

ggplot(avgvotes)+
  geom_ribbon(aes(x=year,ymin=Q1,ymax=Q3), fill = "#006BB6", alpha = 0.15) +
  geom_line(aes(x=year,y=Median), col="#006BB6") +
  labs(x="Year", y="Median of Mean IMDb Movie Score", title="Median of Mean IMDb Movie Scores Over Time") +
  theme_classic()

ggplot()+
  geom_ribbon(data = subset(genvotes, genre == "Action"), aes(x=year,ymin=Q1,ymax=Q3, fill = "Action"), alpha = 0.15) +
  geom_ribbon(data = subset(genvotes, genre == "Drama"), aes(x=year,ymin=Q1,ymax=Q3, fill = "Drama"), alpha = 0.15) +
  geom_line(data = subset(genvotes, genre == "Action"), aes(x=year,y=Median, col= "Action")) +
  geom_line(data = subset(genvotes, genre == "Drama"), aes(x=year,y=Median, col= "Drama")) +
  labs(x="Year", y="Median of Mean IMDb Movie Score", title="Median of Mean IMDb Movie Scores Over Time") +
  scale_fill_manual(name = "Genre", values = c("Action" = "#006BB6", "Drama" = "#F58426"))+
  scale_color_manual(name = "Genre", values = c("Action" = "#006BB6", "Drama" = "#F58426"))+
  theme_classic()

write.csv(genvotes, file = "genvotes.csv")

