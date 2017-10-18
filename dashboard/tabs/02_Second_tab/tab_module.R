# Shiny leaflet module (leaflet package)

# source: https://rstudio.github.io/leaflet/

# UI function
tab_2_ui <- function(id) {

  # Create the unique namespace for the tab
  ns <- NS(id)

  # Build UI

  fluidPage(

    fluidRow(

        box(width = 12,

            tagList(
              titlePanel("Retweets"),
              visNetworkOutput("sna_retweet"),

              p()#,
              #actionButton(ns("recalc"), "New points")
            ),
        box( width = 12, 
             tagList(
               titlePanel("Retweet Metrics"),
               DT::dataTableOutput("sna_ret_metrics")
                )
                 
            )
        )
        
    ) # end: fluidRow
  ) # end: fluidPage

} # end: tab_2_ui()

# Server function
tab_2_server <- function(input, output, session) {

  output$network_game <- renderVisNetwork({
    #if (is.null(input$date_game)) return(NULL) 
    
    # final_game_db<-get_data_network()
    # player_positions <- final_game_db[,c("PASS_TO", "PASS_TO_POSITION")]
    # names(player_positions) <- c("name", "position")
    # p1 <- final_game_db[,c("PLAYER_NAME_LAST_FIRST", "PLAYER_POSITION")] 
    # names(p1)<- c("name", "position")
    # player_positions<-rbind(player_positions,p1)
    # 
    # player_positions<- player_positions[duplicated(player_positions)==FALSE, ]
    # names(player_positions) <- c("name", "position")
    # #print("Net")
    # #print(player_positions)
    # 
    # final_game_db<- final_game_db[,c("PLAYER_NAME_LAST_FIRST", "PASS_TO", "pass")]
    # names(final_game_db) <- c("from", "to", "weight")
    # 
    # g=graph.data.frame(final_game_db, directed = TRUE, 
    #                    vertices= data.frame(player_positions)
    # )
    # 
    # upp <- unique(player_positions$position)
    # cbbPalette<-def_palette[1:length(upp)]
    # names(cbbPalette) <- upp
    # 
    # E(g)$width <- 1+E(g)$weight/4
    # V(g)$color <- cbbPalette[player_positions$position[match(V(g)$name, player_positions$name)]]
    # E(g)$color <- "blue4"
    # 
    # visIgraph(g) %>%   visOptions(highlightNearest = TRUE,  selectedBy = "position")
    # 
  
    
  })
  
  
  output$sna_ret_metrics <- renderDataTable({
    # if (is.null(input$date_game)) return(NULL) 
    # 
    # final_game_db<-get_data_network()
    # player_positions <- final_game_db[,c("PASS_TO", "PASS_TO_POSITION")]
    # player_positions<- player_positions[duplicated(player_positions)==FALSE, ]
    # names(player_positions) <- c("name", "position")
    # 
    # final_game_db<- final_game_db[,c("PLAYER_NAME_LAST_FIRST", "PASS_TO", "pass")]
    # game_db_metrics <- subset(final_game_db, PASS_TO != 'FGM' &  PASS_TO != 'AST'  &  PASS_TO != 'REB' & 
    #                             PASS_TO != 'FG3M' &  PASS_TO != 'STL'  &  PASS_TO != 'FGA')
    # 
    # all_players <- unique(c(game_db_metrics[,'PLAYER_NAME_LAST_FIRST'],
    #                         game_db_metrics[,'PASS_TO']))
    # db_players<- data.frame(data.table::CJ(x=all_players,y=all_players))
    # 
    # names(db_players)<- c("PLAYER_NAME_LAST_FIRST", "PASS_TO")
    # final_game_db <- merge(db_players,game_db_metrics, by= c("PLAYER_NAME_LAST_FIRST", "PASS_TO"),
    #                        all.x= TRUE )
    # final_game_db[is.na(final_game_db)] <- 0
    # matrix =  as.matrix(xtabs(pass~ PLAYER_NAME_LAST_FIRST+ PASS_TO, final_game_db))
    # 
    # g<-graph.adjacency(matrix)
    # # Degree Centrality 
    # cent_in<- centralization.degree(g, mode ="in")$res
    # cent_out<-centralization.degree(g, mode ="out")$res
    # clos<-centralization.closeness(g)$res
    # bet<- centralization.betweenness(g)$res
    # df_f<- as.data.frame(colnames(matrix))
    # df_f$degree_in<-  cent_in
    # df_f$degree_out<- cent_out
    # df_f$clos<- round(clos,2)
    # df_f$bet<- round(bet,2)
    # colnames(df_f)[1] <- "Players"
    # colnames(df_f)[2] <- "Degree In"
    # colnames(df_f)[3] <- "Degree Out"
    # colnames(df_f)[4] <- "Closeness"
    # colnames(df_f)[5] <- "Betweenness"
    # DT::datatable(df_f,options = list(paging = FALSE, searching= FALSE, autoWidth= TRUE))
     
    
  })

} # end: tab_2_server()
