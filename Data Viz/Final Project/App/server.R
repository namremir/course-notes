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

    output$genmedPlot <- renderPlot({

        gen1 <- names(genre_indicator)[genre_indicator == input$genreType1]
        gen2 <- names(genre_indicator)[genre_indicator == input$genreType2]
        
        ggplot()+
            geom_ribbon(data = subset(genvotes, genre == input$genreType1), aes(x=year,ymin=Q1,ymax=Q3, fill = input$genreType1), alpha = 0.15) +
            geom_ribbon(data = subset(genvotes, genre == input$genreType2), aes(x=year,ymin=Q1,ymax=Q3, fill = input$genreType2), alpha = 0.15) +
            geom_line(data = subset(genvotes, genre == input$genreType1), aes(x=year,y=Median, col= input$genreType1), size = 1, alpha = 0.85) +
            geom_line(data = subset(genvotes, genre == input$genreType2), aes(x=year,y=Median, col= input$genreType2), size = 1, alpha = 0.85) +
            labs(x="Year", y="Median of Mean IMDb Movie Score", title=paste("Median of Mean IMDb Movie Scores Over Time for",gen1,"Movies and",gen2,"Movies"), color = "Genre", fill = "Genre") +
            theme_classic()

    })
    
    output$gendagePlot <- renderPlot({
        
        gender <- names(gender_indicator)[gender_indicator == input$genderType]
        age <- names(age_indicator)[age_indicator == input$ageType]
        
        ggplot(sumvotes)+
            geom_line(aes_string(x='year',y=gsub(" ","",paste("tot",input$genderType,input$ageType))), col = "#006BB6", size = 1.25, alpha = 0.65) +
            labs(x="Year", y="Total Votes", title=paste("Total IMDb Votes for",gender,"Ages",age)) +
            scale_y_continuous(labels = comma) +
            theme_classic()
        
    })
    
    output$agePlot <- renderPlot({
        gender <- names(gender_indicator)[gender_indicator == input$genderType]

        ggplot(sumvotes)+
            geom_line(aes_string(x='year',y=gsub(" ","",paste(input$genderType,"18Un")), col = shQuote("0-17")), size = 1.25, alpha = 0.65) +
            geom_line(aes_string(x='year',y=gsub(" ","",paste(input$genderType,"18Up")), col = shQuote("18-29")), size = 1.25, alpha = 0.65) +
            geom_line(aes_string(x='year',y=gsub(" ","",paste(input$genderType,"30U")), col = shQuote("30-44")), size = 1.25, alpha = 0.65) +
            geom_line(aes_string(x='year',y=gsub(" ","",paste(input$genderType,"45U")), col = shQuote("45+")), size = 1.25, alpha = 0.65) +
            labs(x="Year", y="Total Votes", title=paste("Average IMDb Rating for",gender,"by Age")) +
            scale_color_manual(name = "Age Group", values = c("0-17" = "#FDB927", "18-29" = "#F58426", "30-44" = "#552583", "45+" = "#006BB6")) +
            scale_y_continuous(labels = comma) +
            theme_classic()
        
    })

})