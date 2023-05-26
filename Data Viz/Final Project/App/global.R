library(shiny)
library(tidyverse)
library(viridis)
library(ggrepel)
library(scales)

genvotes <- read_csv("genvotes.csv")
genvotes <- genvotes[, c(2,3,4,5,6)]
sumvotes <- read_csv("sumvotes.csv")
sumvotes <- sumvotes[, -c(1)]

genre_indicator <- c("Action" = "Action",
                     "Adventure" = "Adventure",
                     "Comedy" = "Comedy",
                     "Crime" = "Crime",
                     "Drama"= "Drama",
                     "Fantasy" = "Fantasy",
                     "Historical" = "Historical",
                     "Horror" = "Horror",
                     "Mystery" = "Mystery",
                     "Romance" = "Romance",
                     "Thriller" = "Thriller",
                     "Western" = "Western",
                     "Scifi" = "Scifi")

gender_indicator <- c("Men" = "men",
                      "Women" = "women",
                      "All Genders" = "all")

age_indicator <- c("0-17" = "18Un",
                   "18-29" = "18Up",
                   "30-44" = "30U",
                   "45+" = "45U")