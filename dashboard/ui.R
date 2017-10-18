############################## CREATE THE SIDEBAR ##############################
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Summary", tabName = "Tab0", icon = icon("info-circle")),
             #collapsible= 
              # menuSubItem("Default1", tabName = "not_used1", icon=icon('filter')),
              #menuSubItem("Executive Summary", tabName = "Tab0_Sum", icon=icon('filter')),
              #menuSubItem("Datasets", tabName = "datasets", icon=icon('filter'))),
    menuItem("Factor Variables",      tabName = "Tab1", icon = icon("certificate")),
    menuItem("Twitter Social Nets",      tabName = "Tab2", icon = icon("globe"))
    #menuItem("Fun with timeseries",       tabName = "Tab3", icon = icon("line-chart")),
    #menuItem("Look at phone data",        tabName = "Tab4", icon = icon("mobile-phone")),
    #menuItem("Networks",                  tabName = "Tab5", icon = icon("link"))
  ),

  # Logo in sidebar menu
  div(style = "position: fixed; bottom: 35px; left: 35px;",
      img(src = 'tb_images/tb_logo.png', width = 197)
  )
)

############################### CREATE THE BODY ################################
body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "AdminLTE.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "_all-skins.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "skin-yellow.min.css")
  ),

  # Write the UI reference of the modules
  tabItems(
    tabItem(tabName = "Tab0", tab_0_ui("tab_0")),
    tabItem(tabName = "Tab1", tab_1_ui("tab_1")),
    tabItem(tabName = "Tab2", tab_2_ui("tab_2")),
    tabItem(tabName = "Tab3", tab_3_ui("tab_3")),
    tabItem(tabName = "Tab4", tab_4_ui("tab_4")),
    tabItem(tabName = "Tab5", tab_5_ui("tab_5"))
  )
)

#################### PUT THEM TOGETHER INTO A DASHBOARDPAGE ####################
dashboardPage(skin = "yellow",
  dashboardHeader(title = "PC Labs Demo"),
  sidebar,
  body
)
