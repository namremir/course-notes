#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Crimeminder: State Crime Rates"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("crimeType",
                        "Select a Crime:",
                        crime_rate_indicator),
            
            selectInput("state",
                        "Select One or More States:",
                        levels(as.factor(crime_data$State)),
                        multiple=T,
                        selected="United States-Total")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("stateCrime")
        )
    ),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("year",
                        "Select a Year:",
                        min=1960, max=2014, value=2000, sep=""),
            
            selectInput("crimeType1",
                        "Select a Crime for the x-axis:",
                        crime_rate_indicator),
            
            selectInput("crimeType2",
                        "Select a Crime for the y-axis:",
                        crime_rate_indicator)
        ),
        
        mainPanel(
            plotOutput("bubbleplot")
        )
    )
))
