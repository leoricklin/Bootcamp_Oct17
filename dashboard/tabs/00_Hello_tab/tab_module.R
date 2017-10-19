# Front page module

# UI function
tab_0_ui <- function() {
  
  tabPanel(
    'Welcome',
    fluidPage(
      titlePanel("PC Labs Demo"),
      fluidRow(
        column(width=8,
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
               ),
               box(title="Powered by", width = NULL,
                   img(src="powered_by.png", width="100%", style="display: block; margin: 0 auto; max-width: 350px;")
               )
        )
      )
    )
  )
} # end: tab_0_ui()

# Server function
tab_0_server <- function(input, output, session) {


} # end: tab_0_server()
