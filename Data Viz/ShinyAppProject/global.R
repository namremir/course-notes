library(shiny)
library(tidyverse)
library(viridis)
library(ggrepel)

crime_data <- read_csv("CrimeStatebyState.csv")

crime_rate_indicator <- c("Overall Violent Crime"="`Violent Crime rate`", "Murder and Manslaughter"="`Murder and nonnegligent manslaughter rate`",
                          "Rape"="`Legacy rape rate /1`", "Robbery"="`Robbery rate`", "Aggravated Assault"="`Aggravated assault rate`",
                          "Property Crime"="`Property crime rate`", "Burglary"="`Burglary rate`", "Larceny and Theft"="`Larceny-theft rate`",
                          "Motor Vehicle Theft"="`Motor vehicle theft rate`")
