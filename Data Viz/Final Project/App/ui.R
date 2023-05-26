#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(viridis)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Median Movie Genre IMDb Ratings over Time"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("genreType1",
                        "Select a Genre:",
                        genre_indicator),
            
            selectInput("genreType2",
                        "Select a Genre:",
                        genre_indicator)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("genmedPlot")
        )
    ),
    
    titlePanel("Average Movie Ratings by Gender and Age"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("genderType",
                        "Select a Gender:",
                        gender_indicator),
            
            selectInput("ageType",
                        "Select an Age Group (only effects first plot):",
                        age_indicator)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("gendagePlot"), 
            plotOutput("agePlot")
        )
    )
))
