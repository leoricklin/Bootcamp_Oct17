# Shiny leaflet module (leaflet package)

# source: https://rstudio.github.io/leaflet/

# UI function
tab_2_ui <- function(id) {

  # Create the unique namespace for the tab
  ns <- NS(id)

  # Build UI

  fluidPage(

    fluidRow(

        box(width = 12,

            tagList(
              titlePanel("Map Functionality"),
              leafletOutput(ns("mymap")),
              p(),
              actionButton(ns("recalc"), "New points")
            )
        )
    ) # end: fluidRow
  ) # end: fluidPage

} # end: tab_2_ui()

# Server function
tab_2_server <- function(input, output, session) {

  # Create 40 dummy data points
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)

  # Plot points on an interactive leaflet map
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points())
  })

} # end: tab_2_server()
