# Shiny worldPhones module

# UI function
tab_4_ui <- function(id) {

  # Create the unique namespace for the tab
  ns <- NS(id)

  # Build UI
  fillCol(height = 600, flex = c(NA, 1),
          inputPanel(
            selectInput(ns("region"), "Region:", choices = colnames(WorldPhones))
          ),
          plotOutput(ns("phonePlot"), height = "100%")
  )

} # end: tab_4_ui()

# Server function
tab_4_server <- function(input, output, session) {

  # Create barplot
  output$phonePlot <- renderPlot({

    barplot(WorldPhones[ , input$region] * 1000,
            ylab = "Number of Telephones", xlab = "Year")

  })
} # end: tab_4_server()
