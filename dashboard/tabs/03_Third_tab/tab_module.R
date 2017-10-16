# Shiny time series module (dygraphs package)

# source: https://rstudio.github.io/dygraphs/

# UI function
tab_3_ui <- function(id) {

  # Create the unique namespace for the tab
  ns <- NS(id)

  # Build UI

  box(width = 12,

    tagList(
      titlePanel("Predicted Deaths from Lung Disease (UK)"),

      fluidRow(
        column(2,
          numericInput(ns("months"), label = "Months to Predict",
                       value = 72, min = 12, max = 144, step = 12),
          checkboxInput(ns("showgrid"), label = "Show Grid", value = TRUE)
        ),
        column(2,
          selectInput(ns("interval"), label = "Prediction Interval",
              choices = c("0.80", "0.90", "0.95", "0.99"),
              selected = "0.95")
        )
      ), # end: fluidRow

      fluidRow(
        column(12,
          dygraphOutput(ns("dygraph"))
        )
      ) # end: fluidRow
    ) # end: tagList
  ) # end: box

} # end: tab_3_ui()

# Server function
tab_3_server <- function(input, output, session) {

  predicted <- reactive({
    hw <- HoltWinters(ldeaths)
    predict(hw, n.ahead = input$months,
            prediction.interval = TRUE,
            level = as.numeric(input$interval))
  })

  # Plot time series
  output$dygraph <- renderDygraph({
    dygraph(predicted(), main = "Predicted Deaths/Month") %>%
      dySeries(c("lwr", "fit", "upr"), label = "Deaths") %>%
      dyOptions(drawGrid = input$showgrid)
  })

} # end: tab_3_server()
