# server code for R Shiny Dashboard Engine demo
shinyServer(function(input, output, session) {
  

  ##############################################################
  #  TWITTER SNA FUNCTIONS
  ##############################################################
  
  data <- function(){
    all_tweets = read.csv( "./data/tweets.csv", stringsAsFactors = FALSE)
    
    re_tweets =  all_tweets[,c("retweeted_status.user.id", "user.id", "text")]
    re_tweets <- re_tweets[complete.cases(re_tweets),] 
    
    names(re_tweets) <- c("user", "origin", "text")
    re_tweets$user <- sapply(re_tweets$user, FUN=as.character)
    re_tweets$origin <- sapply(re_tweets$origin, FUN=as.character)
    
    return(list("all_tweets" = all_tweets,
                "re_tweets" = re_tweets))
    
  }
  
  
  output$sna_retweet <- renderVisNetwork({
    
    re_tweets<-data()$re_tweet
    print("Graph Net")
    
    final_db <- re_tweets %>%
      group_by(user, origin) %>%
      summarize(n())
    
    names(final_db) <- c("from", "to", "weight")
    
    per_a <-final_db[,"from"]
    names(per_a) <- c("name")
    
    per_b <-final_db[,"to"]
    names(per_b) <- c("name")
    print("perbgrph")
    print(dim(per_b))
    
    persons <- rbind(per_a, per_b)
    
    persons <- persons[!apply(is.na(persons) | persons == "", 1, all),]
    
    edge_names<- persons[duplicated(persons)==FALSE, ]
    edge_names <- unique(persons)
    print("edges gaphs")
    print(dim(edge_names))
    
    
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
    
    
  })
  
  
  output$sna_ret_metrics <- renderDataTable({
    
    
    re_tweets<-data()$re_tweet
    print(dim(re_tweets))
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
    
    edge_names<- persons[duplicated(persons)==FALSE, ]
    edge_names <- unique(persons)
    
    
    edge_names <- sapply(edge_names, FUN=as.character)
    
    final_game_db  <- data.table::CJ(edge_names, edge_names)
    
    names(final_game_db) <- c("to", "from")
    
    final_game_db <-  merge(final_game_db, final_db,by= c("to", "from"), all.x=TRUE )
    final_game_db[is.na(final_game_db),] <- 0
    
    final_game_db$to <- as.character(final_game_db$to)
    final_game_db$from <- as.character(final_game_db$from)
    
    matrix <- as.matrix(stats::xtabs(weight~ from+ to, final_game_db, na.action = na.omit))

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
    colnames(df_f)[1] <- c("User","Degree In", "Degree Out", "Closeness", "Betweenness")
    DT::datatable(df_f,options = list(paging = FALSE, searching= FALSE, autoWidth= TRUE))
    
    
  })
  
    
  #-------------------------------------------------------------
  #  END TWITTER SNA FUNCTIONS
  #-------------------------------------------------------------
  
  ##############################################################
  #  TWITTER WORDCLOUD FUNCTIONS
  ##############################################################
  
  business<-read.csv("data/tweets.csv")
  business1=business[,c("id","text","retweeted")]
  
  docs <- Corpus(VectorSource(business1$text))
  #inspect(docs)
  toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  docs <- tm_map(docs, toSpace, "/")
  docs <- tm_map(docs, toSpace, "@")
  docs <- tm_map(docs, toSpace, "\\|")
  docs <- tm_map(docs, toSpace, "'")
  docs <- tm_map(docs, toSpace, "ðŸ˜")
  docs <- VCorpus(VectorSource(readLines("data/tweets.csv", encoding = "UTF-8")))
  
  # Remove numbers
  docs <- tm_map(docs, removeNumbers)
  
  # Remove english common stopwords
  docs <- tm_map(docs, removeWords, stopwords("english"))
  
  # Remove your own stop word
  # specify your stopwords as a character vector
  
  docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
  
  # specify your stopwords as a character vector
  docs <- tm_map(docs, removeWords, c("oct","relnofollowuetwitter","the","day")) 
  
  # Remove punctuations
  docs <- tm_map(docs, removePunctuation)
  
  # Eliminate extra white spaces
  docs <- tm_map(docs, stripWhitespace)
  
  # Text stemming
  #docs <- tm_map(docs, stemDocument)
  
  dtm <- TermDocumentMatrix(docs)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  #head(d, 14)
  
  set.seed(1234)
  
  output$word_cloud <- renderPlot({
    wordcloud(words = d$word, freq = d$freq, min.freq = 1,
              max.words=200, random.order=FALSE, rot.per=0.35,
              colors=brewer.pal(8, "Dark2"))    
  })
  
  findFreqTerms(dtm, lowfreq = 4)
  findAssocs(dtm, terms = "trump", corlimit = 0.3)
  #head(d, 10)
  
  
  output$word_freq <- renderPlot({
    
    # Render a barplot
    
    barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
            col ="lightblue", main ="Most frequent words",
            ylab = "Word frequencies"
    )
  })
  
  
  #-------------------------------------------------------------
  #  END TWITTER WORDCLOUD FUNCTIONS
  #-------------------------------------------------------------  
  
  #####################
  ## correlates plot ##
  #####################
  
  output$gvis <- renderGvis({
    gvisMotionChart(qog_dat, 
                    idvar="country", 
                    colorvar = "continent",
                    timevar="year",
                    sizevar = "pop_size",
                    xvar = "infant_mortality",
                    yvar = "homicides")
  })
  
})
