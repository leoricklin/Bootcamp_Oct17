# Front page module

# UI function
tab_0_ui <- function() {
  
  # Create list of partner logos
  logos <- list.files("www/external_logos", full.names = TRUE)
  logos <- stringr::str_replace_all(logos, "www/", "")  
  
  tabPanel(
    'Welcome',
    fluidPage(
      titlePanel("PC Labs Demo"),
      fluidRow(
        column(width=6,
               box(title='The Business Problem', width = NULL,
                   p("A financial institution has launched an initiative to adopt Artificial Intelligence to automate their internal Documents process. The aim of this initiative is to speed up processing, reduce manual effort, reduce human errors, optimize resource productivity."),
                   p('This initiative covers several challenges including document classification, handwriting recognition, entity detection / localization, signature detection and entity extraction.These techniques are being covered by Deep Learning emerging technologies that overall act as a Cognitive System. The document data set can be found on three different formats: scanned image, numeric document, Hybrid. The documents have a variable quality depending on the origin of the scan potentially could be below 150ppx.')
               ),
               box(title='Our Approach', width = NULL,
                   p("Our approach involved the development of four main groups of cognitive capabilities, each one with different methodologies, complexities and adapted to the documents and fields required to extract."),
                   tags$ol(
                     tags$li('Factor Variables - reads the text of each document and performs a classification of the document using Machine Learning'),
                     tags$li('Twitter Social Network Analysis - leverages a combination of Deep Learning & OCR+NLP  to detect entities, forms, signature, dates and stores .CSV\'s & cropped images with relevant information.')
                   )
               )
        ),
        column(width=6,
               box(title='Key Benefits and Outcomes', width = NULL,
                   tags$ul(
                     tags$li("Found key failures patterns and key failures signals"),
                     tags$li("Predict with 80%+ accuracy switch parts failures for a forecast of 30/90/180/360 days"),
                     tags$li("Leveraging business assumption simulated €2-5m potential savings per year"),
                     tags$li("Interactive map for descriptive statistical analysis")
                   )
               ),
               box(title='Data Overview', width = NULL,
                   tags$ul(
                     tags$li("2,5 years of data"),
                     tags$li("2 terabytes of data"),
                     tags$li("13.000 switches"),
                     tags$li("17.000 faults"),
                     tags$li("95 mio switching of the points"),
                     tags$li("400 mio vehicle crossings")
                   )
               )
        )        
      ), # end:fluidRow
      fluidRow(
        box(width = 12, h3("Our Partners"), p(),
            lapply(logos,  function(logo) img(src = logo, width = 100))
        )
        
      ) # end:fluidRow
    )
  )
} # end: tab_0_ui()

# Server function
tab_0_server <- function(input, output, session) {


} # end: tab_0_server()
