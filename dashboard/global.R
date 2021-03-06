rm(list=c(ls()))

print(getwd())

################################################################################################
#  Load Packages
################################################################################################
if(!require(shiny))          {install.packages('shiny', dependencies = TRUE);require(shiny)}
if(!require(shinydashboard)) {install.packages('shinydashboard', dependencies = TRUE);require(shinydashboard)}
if(!require(leaflet))       {install.packages('leaflet', dependencies = TRUE);require(leaflet)}
if(!require(stringr))        {install.packages('stringr', dependencies = TRUE);require(stringr)}
if(!require(dygraphs))        {install.packages('dygraphs', dependencies = TRUE);require(dygraphs)}
if(!require(visNetwork))        {install.packages('visNetwork', dependencies = TRUE);require(visNetwork)}
if(!require(dplyr))        {install.packages('dplyr', dependencies = TRUE);require(dplyr)}
if(!require(ggplot2))        {install.packages('ggplot2', dependencies = TRUE);require(ggplot2)}
if(!require(data.table))        {install.packages('data.table', dependencies = TRUE);require(data.table)}
if(!require(igraph))        {install.packages('igraph', dependencies = TRUE);require(igraph)}
if(!require(dplyr))        {install.packages('dplyr', dependencies = TRUE);require(dplyr)}
if(!require(SnowballC))        {install.packages('SnowballC', dependencies = TRUE);require(SnowballC)}
if(!require(wordcloud))        {install.packages('wordcloud', dependencies = TRUE);require(wordcloud)}
if(!require(tm))        {install.packages('tm', dependencies = TRUE);require(tm)}

#Added packages
if(!require(DT))        {install.packages('DT', dependencies = TRUE);require(DT)}
if(!require(googleVis))        {install.packages('googleVis', dependencies = TRUE);require(googleVis)}

##################
## read in data ##
##################

qog_dat <- read.csv("data/qog_reduced.csv")
qog_pca <- read.csv("data/pca_df.csv")
qog_corr <- read.csv("data/corrs_df.csv")

################################################################################################
#  Load Modules
################################################################################################

#-------------------------
#  Tab 0
#-------------------------
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


#-------------------------
#  Tab 1
#-------------------------

tab_1_ui <- function() {

  tabPanel(
    'Correlates of Criminal Behaviour',
    fluidPage(
      titlePanel("Identifying potential influences on criminal behaviour internationally"),
      p("We identified international time series data from the following sources:"),
      p("1.	Quality of Governance standard data (2000 variables from 200 data sources)"),
      p("2. World bank data on global homicide rates since 1945"),
      p(),
      p("The data was passed through an extensive cleaning and processing pieline to identify the highest quality variables."),
      conditionalPanel(
        condition="($('html').hasClass('shiny-busy'))",
        img(src="loading.gif")
      ),      
      fluidRow(
        box(width = 12,
            tagList(
              titlePanel("Comparisions of countries over time"),
              htmlOutput("gvis"),
              p()#,
            )
        )
      ), # end: fluidRow
      p(),
      h3("Correlations of homicide rate with covariates:"),
      fluidRow(
        column(12,
               tableOutput('corr_table')
        )
      ),
      p(),
      h3("Principal Components Analysis:"),
      fluidRow(
        column(12, tableOutput('pca_table')
        )
      )
    )
  ) 
} # end: tab_1_ui()

#-------------------------
#  Tab 2
#-------------------------

tab_2_ui <- function() {
  
  fluidPage(
    titlePanel("Twitter Social Network Analysis"),
    p("The two tabs below will show the following:"),
    p("1. A graph plot of how users are connected based on the retweets"),
    p("2. A wordcloud of the tweets to see the common words / topics being discussed."),    
    conditionalPanel(
      condition="($('html').hasClass('shiny-busy'))",
      img(src="loading.gif")
    ),
    tabBox(title='', width=NULL, side = 'left', selected = 'Twitter Social Nets',
        tabPanel(
          'Twitter Social Nets',
            fluidRow(
              box(width = 12,
                  tagList(
                    titlePanel("Retweets"),
                    visNetworkOutput("sna_retweet"),
                    p()#,
                  ),
                  box( width = 12, 
                       tagList(
                         titlePanel("Retweet Metrics"),
                         DT::dataTableOutput("sna_ret_metrics")
                       )
                  )
              )
            ) # end: fluidRow
        ), # end: tabPanel
        tabPanel(
          'Twitter Word Cloud',
          fluidRow(
            box(width = 12,
                titlePanel("Word Cloud"),
                plotOutput('word_cloud')
            ),
            box(width = 12, 
                titlePanel("Word Frequency"),
                plotOutput('word_freq')
            )
          ) # end: fluidRow
        ) # end: tabPanel        
    ) # end: tabBox
  )
  
} # end: tab_2_ui()