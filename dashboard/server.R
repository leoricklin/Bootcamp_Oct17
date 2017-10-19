# server code for R Shiny Dashboard Engine demo
shinyServer(function(input, output, session) {
  
  #observeEvent(input$run_sna, {
  #  print('ADD CALL TO TWITTER CHARTS HERE')  
  #})  
  
  ##############################################################
  #  TWITTER SNA FUNCTIONS
  ##############################################################
  
  data <- function(){
    print('ADD CALL TO TWITTER CHARTS HERE') 
    all_tweets = read.csv( "./data/tweets.csv", stringsAsFactors = FALSE)
    
    re_tweets =  all_tweets[,c("retweeted_status.user.id", "user.id", "text")]
    re_tweets <- re_tweets[complete.cases(re_tweets),] 
    
    names(re_tweets) <- c("user", "origin", "text")
    re_tweets$user <- sapply(re_tweets$user, FUN=as.character)
    re_tweets$origin <- sapply(re_tweets$origin, FUN=as.character)
    
    #re_tweets$user <- as.character(re_tweets$user)
    #re_tweets$origin <- as.character(re_tweets$origin)
    
    return(list("all_tweets" = all_tweets,
                "re_tweets" = re_tweets))
    
    #assign("all_tweets", all_tweets, envir = .GlobalEnv)
    
    #assign("re_tweets", re_tweets, envir = .GlobalEnv)
  }
  
  
  output$network_game <- renderVisNetwork({
    
    re_tweets<-data()$re_tweet
    print("Net")
    
    final_db <- re_tweets %>%
      group_by(user, origin) %>%
      summarize(n())
    
    names(final_db) <- c("from", "to", "weight")
    
    per_a <-final_db[,"from"]
    names(per_a) <- c("name")
    
    per_b <-final_db[,"to"]
    names(per_b) <- c("name")
    
    persons <- rbind(per_a, per_b)
    #edge_names<- persons[duplicated(persons)==FALSE, ]
    edge_names <- unique(persons)
    
    g <-graph.data.frame(final_db, directed = TRUE,
                         vertices= data.frame(edge_names)
    )
    #
    #upp <- unique(player_positions$position)
    #cbbPalette<-def_palette[1:length(upp)]
    #names(cbbPalette) <- upp
    
    E(g)$width <- 1+E(g)$weight/4
    # V(g)$color <- cbbPalette[player_positions$position[match(V(g)$name, player_positions$name)]]
    E(g)$color <- "blue4"
    #
    visIgraph(g) %>%   visOptions(highlightNearest = TRUE,  selectedBy = "position")
    #
    
    
  })
  
  
  output$sna_ret_metrics <- renderDataTable({
    
    # all_players <- unique(c(game_db_metrics[,'PLAYER_NAME_LAST_FIRST'],
    #                         game_db_metrics[,'PASS_TO']))
    # db_players<- data.frame(data.table::CJ(x=all_players,y=all_players))
    # 
    # names(db_players)<- c("PLAYER_NAME_LAST_FIRST", "PASS_TO")
    # final_game_db <- merge(db_players,game_db_metrics, by= c("PLAYER_NAME_LAST_FIRST", "PASS_TO"),
    #                        all.x= TRUE )
    # final_game_db[is.na(final_game_db)] <- 0
    
    re_tweets<-data()$re_tweet
    
    print("Net")
    
    final_db <- re_tweets %>%
      group_by(user, origin) %>%
      summarize(n())
    
    names(final_db) <- c("from", "to", "weight")
    
    per_a <-final_db[,"from"]
    names(per_a) <- c("name")
    
    per_b <-final_db[,"to"]
    names(per_b) <- c("name")
    
    persons <- rbind(per_a, per_b)
    #edge_names<- persons[duplicated(persons)==FALSE, ]
    edge_names <- unique(persons)
    edge_names <- sapply(edge_names, FUN=as.character)
    
    final_game_db  <- data.table::CJ(edge_names, edge_names)
    
    names(final_game_db) <- c("to", "from")
    
    final_game_db <-  merge(final_game_db, final_db,by= c("to", "from"), all.x=TRUE )
    final_game_db[is.na(final_game_db)] <- 0
    
    matrix <- as.matrix(xtabs(weight~ from + to, final_game_db))
    
    g<-graph.adjacency(matrix)
    # Degree Centrality 
    cent_in<- centralization.degree(g, mode ="in")$res
    cent_out<-centralization.degree(g, mode ="out")$res
    clos<-centralization.closeness(g)$res
    bet<- centralization.betweenness(g)$res
    df_f<- as.data.frame(colnames(matrix))
    df_f$degree_in<-  cent_in
    df_f$degree_out<- cent_out
    df_f$clos<- round(clos,2)
    df_f$bet<- round(bet,2)
    colnames(df_f)[1] <- "User"
    colnames(df_f)[2] <- "Degree In"
    colnames(df_f)[3] <- "Degree Out"
    colnames(df_f)[4] <- "Closeness"
    colnames(df_f)[5] <- "Betweenness"
    DT::datatable(df_f,options = list(paging = FALSE, searching= FALSE, autoWidth= TRUE))
    
    
  })
  
  #-------------------------------------------------------------
  #  END TWITTER SNA FUNCTIONS
  #-------------------------------------------------------------
  
  #####################
  ## correlates plot ##
  #####################
  
  output$gvis <- renderGvis({
    # gvisGeoChart(myData,
    #              locationvar="state", colorvar="demVote",
    #              options=list(region="US", displayMode="regions", 
    #                           resolution="provinces",
    #                           width=500, height=400,
    #                           colorAxis="{colors:['#FFFFFF', '#0000FF']}"
    #              ))
    gvisMotionChart(qog_dat, 
                    idvar="country", 
                    colorvar = "continent",
                    timevar="year",
                    sizevar = "pop_size",
                    xvar = "infant_mortality",
                    yvar = "homicides")
  })
  
})
