library(shiny)

# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

# Define a server for the Shiny app
shinyServer(function(input, output) {
      
      # Filter data based on selections
      output$table <- renderDataTable({
            data <- allFY
            if (input$agency != "All"){
                  data <- data[data$Agency == input$agency,]
            }
            if (input$FY != "All"){
                  data <- data[data$Fiscal.Year == input$FY,]
            }
#             if (input$amount != "All"){
#                   data <- data[data$Total == input$amount,]
#             }
            data
      })
      
})