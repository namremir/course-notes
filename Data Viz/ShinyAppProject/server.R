#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$stateCrime <- renderPlot({
        yVarName <- names(crime_rate_indicator)[crime_rate_indicator == input$crimeType]
        
        plot1_data <- filter(crime_data, State %in% input$state)
        
        ggplot(plot1_data) +
            geom_line(size=1.5, aes_string(x="Year", y=input$crimeType, color="State")) +
            labs(x=element_blank(),
                 y=yVarName, title=paste(yVarName,"Rate from 1960 to 2014 for\n",paste(input$state,collapse=", "))) +
            scale_color_viridis(option="plasma", discrete=T) +
            theme_classic()
    
    })
    
    output$bubbleplot <- renderPlot({
        yVarName1 <- names(crime_rate_indicator)[crime_rate_indicator == input$crimeType2]
        xVarName1 <- names(crime_rate_indicator)[crime_rate_indicator == input$crimeType1]
        
        plot2_data <- filter(crime_data, Year %in% input$year, State != "United States-Total")
        
        ggplot(plot2_data) +
            geom_point(aes_string(x=input$crimeType1, y=input$crimeType2, size="Population", color="State"), alpha=.7) +
            scale_color_viridis(option="plasma", discrete=T) +
            labs(x=xVarName1, y=yVarName1, title=paste(yVarName1,"vs.",xVarName1,"in",paste(input$year,collapse=", "),
                                                       "\nWith Size Proportional to Population")) +
            guides(size=F) +
            theme_classic()
    })

})
