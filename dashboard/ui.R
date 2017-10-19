# set black and white plot theme
theme_set(theme_bw())

sidebar <- shinydashboard::dashboardSidebar(
  sidebarMenu(
    id = 'navpage',
    menuItem("Welcome", tabName = "welcome_page", icon = icon("info-circle")),
    menuItem("Factor Variables", tabName = "factor_variables", icon = icon("area-chart")),
    menuItem("Twitter Social Network Analysis", tabName = "social_network_analysis", icon = icon("twitter"))
  ),

  # Logo in sidebar menu
  div(style = "position: fixed; bottom: 35px; left: 35px;",
      img(src = 'tb_images/tb_logo.png', width = 197)
  )
)

body <- shinydashboard::dashboardBody(
  tags$head(
    tags$style(type="text/css", "
             #loadmessage {
               position: fixed;
               top: 0px;
               left: 0px;
               width: 100%;
               padding: 5px 0px 5px 0px;
               text-align: center;
               font-weight: bold;
               font-size: 100%;
               color: #000000;
               background-color: #CCFF66;
               z-index: 105;
             }
    "),
    tags$link(rel = "stylesheet", type = "text/css", href = "AdminLTE.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "_all-skins.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "skin-yellow.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$link(rel = "shortcut icon", href = "https://www.thinkbiganalytics.com/wp-content/uploads/2016/09/14TDPRD223_Think_Big_Logo_F-150x147.png"),

    # tags$link(rel = "stylesheet", type = "text/css", href = "stylesleaflet.css"),
    # tags$link(rel = "stylesheet", type = "text/css", href = "gomap.js")
    includeCSS("stylesleaflet.css"),
    includeScript("gomap.js")
  ),

  # Write the UI reference of the modules
  tabItems(
    tabItem(tabName = "welcome_page", tab_0_ui()),
    tabItem(tabName = "factor_variables", tab_1_ui()),
    tabItem(tabName = "social_network_analysis", tab_2_ui())
  )
)

shinydashboard::dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "PC Labs Demo"),
  sidebar,
  body
)
