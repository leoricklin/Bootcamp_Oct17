# Front page module

# UI function
tab_1_ui <- function() {
  
  tabPanel(
    'Factor Variables',
    fluidPage(
      titlePanel("Factor Variables"),
      p("Choose a PDF file to be processed. After uploading, this page will automatically convert the PDF file into image, text and xml files."),
      p("Select the page number to view a different page of the PDF, converted output can be seen in the respective tabs below."),
      p("Note: This might take a few minutes to process and return results"),
      p(actionButton(inputId = "run_factor_analysis", label = "Run"))
      
    )
  )

} # end: tab_1_ui()

# Server function
tab_1_server <- function(input, output, session) {

  observeEvent(input$run_factor_analysis, {
    print('ADD CALL TO FACTOR ANALYSIS HERE')  
  })  

} # end: tab_1_server()

