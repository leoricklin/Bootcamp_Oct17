# Front page module

# UI function
tab_0_ui <- function(id) {

  # Basically not needed. Just kept here to preserve commonality across files.
  ns <- NS(id)

  # Main UI

  
  # Basically not needed. Just kept here to preserve commonality across files.
  ns <- NS(id)
  
  # Create list of partner logos
  logos <- list.files("www/external_logos", full.names = TRUE)
  logos <- stringr::str_replace_all(logos, "www/", "")
  
  # Main UI
  fluidPage(
    
    fluidRow(
      box(width = 6, h3("Business Problem"), p(),
          
          tags$ol(
            tags$li("A railway company wanted to understand if it was possible to predict Switch part failures, leveraging IoT + other Maintenance and Faults Data."),
            tags$li("If such failures could be predicted within a time frame that enables operation teams to react, several trains disruptions could be prevented which would mean an improvement of customer satisfaction, reduction of maintenance costs with pro-active work orders to fix the part before they are faulty
                    or even optimise supply chain by ordering parts as needed to minimise switch downtime."),
            tags$li("In order to develop such predictive modelling framework, several datasets needs to be analysed and blended, from replacement data to switch parts characteristics.")
            )
      ),
      
      box(width = 6, h3("Key Benefits and Outcomes"), p(),
          
          tags$ul(
            tags$li("Found key failures patterns and key failures signals"),
            tags$li("Predict with 80%+ accuracy switch parts failures for a forecast of 30/90/180/360 days"),
            tags$li("Leveraging business assumption simulated €2-5m potential savings per year"),
            tags$li("Interactive map for descriptive statistical analysis")
          )
      )
      ), # end: fluidRow
    
    fluidRow(
      box(width = 6, h3("Our Approach"), p(),
          tags$ul(
            tags$li("Created a 'Modelling' dataset blending failures with historical parameters and switch attributes"),
            tags$li("Developed Failures Profiling analysis to see trends and key correlations among the data"),
            tags$li("Performed Survival Statistical Analysis to understand key failures risk indicators"),
            tags$li("Run Survival Machine Learning models to model and predict failures for a 30/90/180/360 days forecast")
          )
      ),
      
      box(width = 6, h3("Data Overview"), p(),
          
          tags$ul(
            tags$li("2,5 years of data"),
            tags$li("2 terabytes of data"),
            tags$li("13.000 switches"),
            tags$li("17.000 faults"),
            tags$li("95 mio switching of the points"),
            tags$li("400 mio vehicle crossings")
          )
      )
    ),# end: fluidRow
    
    fluidRow(
      box(width = 12, h3("Our Partners"), p(),
          lapply(logos,  function(logo) img(src = logo, width = 100))
      )
      
    ) # end: fluidRow
    
    ) # end: fluidPage
  
} # end: tab_0_ui()

# Server function
tab_0_server <- function(input, output, session) {

  # Empty, since there is no interactivity on the front page

} # end: tab_0_server()
