shinyServer(function(input, output, session) {

########################### CALL EACH OF THE MODULES ###########################

  callModule(tab_0_server, "tab_0")
  callModule(tab_1_server, "tab_1")
  callModule(tab_2_server, "tab_2")
  #callModule(tab_3_server, "tab_3")
  #callModule(tab_4_server, "tab_4")
  #callModule(tab_5_server, "tab_5")

})
