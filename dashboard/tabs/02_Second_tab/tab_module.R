# Shiny leaflet module (leaflet package)

# source: https://rstudio.github.io/leaflet/

# UI function
tab_2_ui <- function(id) {

  tabPanel(
    'Twitter Social Nets',
    fluidPage(
      titlePanel("Twitter Social Nets"),
      p("Choose a model to use for classifying the uploaded PDF file. This step will classify the uploaded document into DBPF, NOMINA or OTHERS.")
    )
  )

} # end: tab_2_ui()

# Server function
tab_2_server <- function(input, output, session) {
  


} # end: tab_2_server()
