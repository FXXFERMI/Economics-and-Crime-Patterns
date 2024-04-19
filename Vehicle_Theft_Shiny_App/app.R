#### Work space Setup ####
library(shiny)
library(ggplot2)
library(DT)

# Load dataset
transposed_data <- read.csv("analysis_data_copy.csv")

# Define the user interface
ui <- fluidPage(
  titlePanel("Interactive Data Viewer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("xAxisColumn", "Select CPI Category for X-axis:",
                  choices = colnames(transposed_data)[-which(colnames(transposed_data) == "Total_Vehicle_Thefts")],
                  selected = "All_items"),
      hr(),
      downloadButton("downloadData", "Download Data")
    ),
    mainPanel(
      DTOutput("dataTable"),
      hr(),
      plotOutput("dataPlot")
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
    datatable(filteredData())
  })
  
  # Downloadable csv of selected dataset
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(filteredData(), file, row.names = FALSE)
    }
  )
  
  # Dynamic scatter plot with regression line
  output$dataPlot <- renderPlot({
    if (is.null(filteredData())) {
      return()  # Do nothing if data is NULL
    }
    req(filteredData())  # ensure that data is not NULL
    ggplot(filteredData(), aes_string(x = input$xAxisColumn, y = "Total_Vehicle_Thefts")) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE) +
      labs(title = paste("Relationship between", input$xAxisColumn, "CPI Inflation Rate and Vehicle Thefts Times"),
           x = input$xAxisColumn, 
           y = "Total Vehicle Thefts")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
