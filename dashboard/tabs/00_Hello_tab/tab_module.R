# Front page module

# UI function
tab_0_ui <- function(id) {

  # Basically not needed. Just kept here to preserve commonality across files.
  ns <- NS(id)

  # Main UI

  fluidPage(

    fluidRow(
      box(width = 6, h3("Goal of package"), p(),
          "The goal of TBdashboard is to make it easy for you to make Think Big Analytics styled dashboards. The dashboard is made using the
          shinydashboard package and then each tab in the dashboard is modularized so each tab work on their own."
      ),
      box(width = 6, h3("How to create a dashboard"), p(),
          "First you run the ",code("TBdashboard::create_dashboard()")," command. This will create a file structure for your dashboard that you can use."
      )
    ), # end: fluidRow

    fluidRow(
      box(width = 6, h3("The Tabs"), p(),
          "The tabs folders are the LEGO bricks of this dashboard. Each folder contain the file ",code("tab_module.R"),".
          This is the file that creates the UI and server logic for each tab. Take a look at the code for the fourth tab about World Phone Data.",
          p(),
          "As you can see, it contains two functions: ",code("tab_4_ui()")," and ",code("tab_4_server()"),". These are the ui and server parts that you know from regular shiny apps. The reason why this dashboard is
          modularized is because each tab folder and corresponding tab_module.R all contain their own ui and server parts. You can read more about Shiny Modules here: ", a(href = "https://shiny.rstudio.com/articles/modules.html","https://shiny.rstudio.com/articles/modules.html."),
          p(),
          strong("Important:"),
          "Be aware of the ",code("ns()")," wrapper. You need to include in all the modules.",
          p(),
          "What you need to do is edit the UI and the server parts to fit your needs. You can delete the tab folders you don’t need and you can duplicate them if you need more."
      ),

      box(width = 6, h3("UI, Server and Global"), p(),
          "Once you have created the tabs you want and updated the code, then you need to make sure that each module will go into the UI part of the whole dashboard.
          Take a look at the code in ",code("ui.R"),".",
          p(),
          "You need to update the ",code("menuItem()")," and the ",code("tabItem()")," lines. If you have created a new tab then update the ui accordingly. You can copy each line and edit it. Remember to edit all
          the relevant places in the line.",
          br(),
          p(),
          "The ",code("server.R")," file calls the server logic from each module. It’s pretty and only contains one line per tab as you can see in the file.",
          br(),
          p(),
          "The ",code("global.R")," file loads the necessary libraries and creates the module functions. You only need to edit the libraries part because we have build a loop that
          automatically creates the module functions from your module tabs. Take a look at the code."
      )

    ) # end: fluidRow

  ) # end: fluidPage

} # end: tab_0_ui()

# Server function
tab_0_server <- function(input, output, session) {

  # Empty, since there is no interactivity on the front page

} # end: tab_0_server()
