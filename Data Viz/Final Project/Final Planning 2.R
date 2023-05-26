library(tidyverse)
library(viridis)
library(scales)

full <- read_csv("IMDb movies.csv")
votes <- read_csv("IMDb ratings.csv")

fullvotes <- full_join(full, votes, by = "imdb_title_id")
filtvotes <- filter(fullvotes, `total_votes` >= 10000)
filtvotes <- filter(filtvotes, `year` >= 1925)

sumvotes <- summarize(group_by(filtvotes, year), 
                      all18Un = median(`allgenders_0age_avg_vote`),
                      all18Up = median(`allgenders_18age_avg_vote`),
                      all30U = median(`allgenders_30age_avg_vote`),
                      all45U = median(`allgenders_45age_avg_vote`),
                      all = median(`mean_vote`),
                      men18Un = median(`males_0age_avg_vote`),
                      men18Up = median(`males_18age_avg_vote`),
                      men30U = median(`males_30age_avg_vote`),
                      men45U = median(`males_45age_avg_vote`),
                      men = median(`males_allages_avg_vote`),
                      women18Un = median(`females_0age_avg_vote`),
                      women18Up = median(`females_18age_avg_vote`),
                      women30U = median(`females_30age_avg_vote`),
                      women45U = median(`females_45age_avg_vote`),
                      women = median(`females_allages_avg_vote`),
                      totall18Un = sum(`allgenders_0age_votes`),
                      totall18Up = sum(`allgenders_18age_votes`),
                      totall30U = sum(`allgenders_30age_votes`),
                      totall45U = sum(`allgenders_45age_votes`),
                      totall = sum(`total_votes`),
                      totmen18Un = sum(`males_0age_votes`),
                      totmen18Up = sum(`males_18age_votes`),
                      totmen30U = sum(`males_30age_votes`),
                      totmen45U = sum(`males_45age_votes`),
                      totmen = sum(`males_allages_votes`),
                      totwomen18Un = sum(`females_0age_votes`),
                      totwomen18Up = sum(`females_18age_votes`),
                      totwomen30U = sum(`females_30age_votes`),
                      totwomen45U = sum(`females_45age_votes`),
                      totwomen = sum(`females_allages_votes`),)

malevotes <- sumvotes[, c(1,25,24,23,22)]
femalevotes <- sumvotes[, c(1,27,28,29,30)]
allvotes <- sumvotes[, c(1,17,18,19,20)]

malesvotes <- gather(malevotes, key = "Age", value = "Votes", -c("year"))
malesvotes[is.na(malesvotes)] = 0
names(malesvotes) <- c("Year","Age","Votes")
femalesvotes <- gather(femalevotes, key = "Age", value = "Votes", -c("year"))
femalesvotes[is.na(femalesvotes)] = 0
names(femalesvotes) <- c("Year","Age","Votes")
allsvotes <- gather(allvotes, key = "Age", value = "Votes", -c("year"))
allsvotes[is.na(allsvotes)] = 0
names(allsvotes) <- c("Year","Age","Votes")

ggplot(malesvotes) +
  geom_area(aes(x=Year, y = Votes, fill = Age)) +
  scale_fill_viridis(discrete = T, labels = c("0-17", "18-29", "30-44", "45+")) +
  scale_y_continuous(labels = comma) +
  labs(x = "Year", y = "Total Votes", title = "Total IMDb Votes by Men by Age Group Over Time") +
  theme_minimal()

ggplot(femalesvotes) +
  geom_area(aes(x=Year, y = Votes, fill = Age)) +
  scale_fill_viridis(discrete = T, labels = c("0-17", "18-29", "30-44", "45+")) +
  scale_y_continuous(labels = comma) +
  labs(x = "Year", y = "Total Votes", title = "Total IMDb Votes by Women by Age Group Over Time") +
  theme_minimal()

ggplot(allsvotes) +
  geom_area(aes(x=Year, y = Votes, fill = Age)) +
  scale_fill_viridis(discrete = T, labels = c("0-17", "18-29", "30-44", "45+")) +
  scale_y_continuous(labels = comma) +
  labs(x = "Year", y = "Total Votes", title = "Total IMDb Votes by Age Group Over Time") +
  theme_minimal()

ggplot(sumvotes) +
  geom_line(aes(x=year,y=men, col = "Men"), size = 1.25, alpha = 0.65) +
  geom_line(aes(x=year,y=women, col = "Women"), size = 1.25, alpha = 0.65)+
  labs(x = "Year", y = "Average Vote", title = "Average Vote Over Time for Men and Women") +
  scale_color_manual(name = "Gender", values = c("Women"="#F58426","Men"="#006BB6")) +
  theme_classic()

write.csv(sumvotes, file = "sumvotes.csv")
