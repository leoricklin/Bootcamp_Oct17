# server code for R Shiny Dashboard Engine demo
shinyServer(function(input, output, session) {
  
  session$onSessionEnded(stopApp)
  callModule(tab_0_server, "tab_0")
  callModule(tab_1_server, "tab_1")
  callModule(tab_2_server, "tab_2")
  
})
