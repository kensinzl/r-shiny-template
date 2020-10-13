function(input, output) {
    
    # Draw a rough NZ map for the dashboard
    output$mymap <- renderLeaflet({ 
        leaflet() %>%
        addTiles() %>% 
        addProviderTiles("Stamen.TonerHybrid") %>%
        fitBounds(lng1 = 171.358804, lat1 = -33.605756, lng2 = 158.393284, lat2 = -55.924586)
    })
    
    # Draw a histogram for the subitem1
    set.seed(122)
    histdata <- rnorm(500)
    
    output$plot1 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
}