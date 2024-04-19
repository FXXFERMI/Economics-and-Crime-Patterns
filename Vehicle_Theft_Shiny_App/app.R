#### Preamble ####
# Purpose: This script creates an interactive data viewer for analyzing the 
#          relationship between CPI categories and vehicle theft rates in 
#          Toronto. It allows users to select different CPI categories and
#          visualize their correlation with vehicle theft occurrences over time.
# Author: Siqi Fei
# Date: 05 April 2024
# Contact: fermi.fei@mail.utoronto.ca
# License: MIT
# Pre-requisites: R environment with the following packages installed: `shiny`, 
#                 `ggplot2`, `DT`.
# Additional Notes: This application is intended to provide a user-friendly 
#                   interface for dynamic exploration of the dataset, enabling
#                   both visualization and data download capabilities. Ensure
#                   the dataset "analysis_data_copy.csv" is updated and located
#                   in the same directory as this script for optimal performance.


#### Work space Setup ####
library(shiny)          # Load shiny for interactive web apps
library(ggplot2)        # Load ggplot2 for creating visualizations
library(DT)             # Load DT for rendering interactive tables

# Load dataset
transposed_data <- read.csv("analysis_data_copy.csv")

# Define the user interface
ui <- fluidPage(
  titlePanel("Interactive Toronto CPI and Auto Thefts Viewer"), # Title of the app
  sidebarLayout(
    sidebarPanel(
      selectInput("xAxisColumn", "Select CPI Category for X-axis:", # Dropdown menu for selecting CPI category
                  choices = colnames(transposed_data)[-which(colnames(transposed_data) == "Total_Vehicle_Thefts")],
                  selected = "All_items"),
      hr(), # Horizontal line for layout separation
      downloadButton("downloadData", "Download Data") # Button to download the data
    ),
    mainPanel(
      DTOutput("dataTable"), # Output table display
      hr(), # Horizontal line for layout separation
      plotOutput("dataPlot") # Output plot display
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Reactive expression to handle the data
  filteredData <- reactive({
    # Ensure selected column exists in transposed_data
    if (input$xAxisColumn %in% colnames(transposed_data)) {
      transposed_data[, c(input$xAxisColumn, "Total_Vehicle_Thefts"), drop = FALSE]
    } else {
      NULL  # Return NULL if the column does not exist
    }
  })
  
  # Render the DataTable
  output$dataTable <- renderDT({
    if (is.null(filteredData())) {
      return(dataTableOutput())  # Return an empty table if data is NULL
    }
    datatable(filteredData()) # Create an interactive data table
  })
  
  # Downloadable csv of selected dataset
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="") # Set the filename with the current date
    },
    content = function(file) {
      write.csv(filteredData(), file, row.names = FALSE) # Write the filtered data to a CSV file
    }
  )
  
  # Dynamic scatter plot with regression line
  output$dataPlot <- renderPlot({
    if (is.null(filteredData())) {
      return()  # Do nothing if data is NULL
    }
    req(filteredData())  # ensure that data is not NULL
    ggplot(filteredData(), aes_string(x = input$xAxisColumn, y = "Total_Vehicle_Thefts")) +
      geom_point() + # Add points to the scatter plot
      geom_smooth(method = "lm", se = FALSE) + # Add a linear model line
      labs(title = paste("Relationship between", input$xAxisColumn, "CPI Inflation Rate and Vehicle Thefts Times"),
           x = input$xAxisColumn, 
           y = "Total Vehicle Thefts") # Set plot labels
  })
}

# Run the application 
shinyApp(ui = ui, server = server)  # Start the shiny app
