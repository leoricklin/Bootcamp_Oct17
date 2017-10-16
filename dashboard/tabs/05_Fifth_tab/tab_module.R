# Shiny network module (visNetwork package)

# source: http://datastorm-open.github.io/visNetwork/

# UI function
tab_5_ui <- function(id) {

  # Create the unique namespace for the tab
  ns <- NS(id)

  fluidPage(

    fluidRow(

      box(width = 12,

          tagList(
            titlePanel("Les miserables Network"),
            visNetworkOutput(ns("mynetwork"))
          )
      )
    ) # end: fluidRow
  ) # end: fluidPage

} # end: tab_5_ui()

# Server function
tab_5_server <- function(input, output, session) {

  nodes <- structure(list(id = 0:76, label = c("Myriel", "Napoleon", "Mlle.Baptistine",
                                               "Mme.Magloire", "CountessdeLo", "Geborand", "Champtercier", "Cravatte",
                                               "Count", "OldMan", "Labarre", "Valjean", "Marguerite", "Mme.deR",
                                               "Isabeau", "Gervais", "Tholomyes", "Listolier", "Fameuil", "Blacheville",
                                               "Favourite", "Dahlia", "Zephine", "Fantine", "Mme.Thenardier",
                                               "Thenardier", "Cosette", "Javert", "Fauchelevent", "Bamatabois",
                                               "Perpetue", "Simplice", "Scaufflaire", "Woman1", "Judge", "Champmathieu",
                                               "Brevet", "Chenildieu", "Cochepaille", "Pontmercy", "Boulatruelle",
                                               "Eponine", "Anzelma", "Woman2", "MotherInnocent", "Gribier",
                                               "Jondrette", "Mme.Burgon", "Gavroche", "Gillenormand", "Magnon",
                                               "Mlle.Gillenormand", "Mme.Pontmercy", "Mlle.Vaubois", "Lt.Gillenormand",
                                               "Marius", "BaronessT", "Mabeuf", "Enjolras", "Combeferre", "Prouvaire",
                                               "Feuilly", "Courfeyrac", "Bahorel", "Bossuet", "Joly", "Grantaire",
                                               "MotherPlutarch", "Gueulemer", "Babet", "Claquesous", "Montparnasse",
                                               "Toussaint", "Child1", "Child2", "Brujon", "Mme.Hucheloup"),
                          group = c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L,
                                    3L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 4L, 4L, 5L,
                                    4L, 0L, 2L, 3L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 4L, 6L, 4L,
                                    4L, 5L, 0L, 0L, 7L, 7L, 8L, 5L, 5L, 5L, 5L, 5L, 5L, 8L, 5L,
                                    8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 9L, 4L, 4L, 4L, 4L,
                                    5L, 10L, 10L, 4L, 8L)), .Names = c("id", "label", "group"
                                    ), class = "data.frame", row.names = c(NA, 77L))

  edges <- structure(list(from = c(1L, 2L, 3L, 3L, 4L, 5L, 6L, 7L, 8L, 9L,
                                   11L, 11L, 11L, 11L, 12L, 13L, 14L, 15L, 17L, 18L, 18L, 19L, 19L,
                                   19L, 20L, 20L, 20L, 20L, 21L, 21L, 21L, 21L, 21L, 22L, 22L, 22L,
                                   22L, 22L, 22L, 23L, 23L, 23L, 23L, 23L, 23L, 23L, 23L, 23L, 24L,
                                   24L, 25L, 25L, 25L, 26L, 26L, 26L, 26L, 27L, 27L, 27L, 27L, 27L,
                                   28L, 28L, 29L, 29L, 29L, 30L, 31L, 31L, 31L, 31L, 32L, 33L, 33L,
                                   34L, 34L, 35L, 35L, 35L, 36L, 36L, 36L, 36L, 37L, 37L, 37L, 37L,
                                   37L, 38L, 38L, 38L, 38L, 38L, 38L, 39L, 40L, 41L, 41L, 42L, 42L,
                                   42L, 43L, 43L, 43L, 44L, 44L, 45L, 47L, 48L, 48L, 48L, 48L, 49L,
                                   49L, 50L, 50L, 51L, 51L, 51L, 52L, 52L, 53L, 54L, 54L, 54L, 55L,
                                   55L, 55L, 55L, 55L, 55L, 55L, 55L, 55L, 55L, 56L, 56L, 57L, 57L,
                                   57L, 58L, 58L, 58L, 58L, 58L, 59L, 59L, 59L, 59L, 60L, 60L, 60L,
                                   61L, 61L, 61L, 61L, 61L, 61L, 62L, 62L, 62L, 62L, 62L, 62L, 62L,
                                   62L, 63L, 63L, 63L, 63L, 63L, 63L, 63L, 63L, 64L, 64L, 64L, 64L,
                                   64L, 64L, 64L, 64L, 64L, 64L, 65L, 65L, 65L, 65L, 65L, 65L, 65L,
                                   65L, 65L, 65L, 66L, 66L, 66L, 66L, 66L, 66L, 66L, 66L, 66L, 67L,
                                   68L, 68L, 68L, 68L, 68L, 68L, 69L, 69L, 69L, 69L, 69L, 69L, 69L,
                                   70L, 70L, 70L, 70L, 70L, 70L, 70L, 70L, 71L, 71L, 71L, 71L, 71L,
                                   71L, 71L, 71L, 72L, 72L, 72L, 73L, 74L, 74L, 75L, 75L, 75L, 75L,
                                   75L, 75L, 75L, 76L, 76L, 76L, 76L, 76L, 76L, 76L), to = c(0L,
                                                                                             0L, 0L, 2L, 0L, 0L, 0L, 0L, 0L, 0L, 10L, 3L, 2L, 0L, 11L, 11L,
                                                                                             11L, 11L, 16L, 16L, 17L, 16L, 17L, 18L, 16L, 17L, 18L, 19L, 16L,
                                                                                             17L, 18L, 19L, 20L, 16L, 17L, 18L, 19L, 20L, 21L, 16L, 17L, 18L,
                                                                                             19L, 20L, 21L, 22L, 12L, 11L, 23L, 11L, 24L, 23L, 11L, 24L, 11L,
                                                                                             16L, 25L, 11L, 23L, 25L, 24L, 26L, 11L, 27L, 23L, 27L, 11L, 23L,
                                                                                             30L, 11L, 23L, 27L, 11L, 11L, 27L, 11L, 29L, 11L, 34L, 29L, 34L,
                                                                                             35L, 11L, 29L, 34L, 35L, 36L, 11L, 29L, 34L, 35L, 36L, 37L, 11L,
                                                                                             29L, 25L, 25L, 24L, 25L, 41L, 25L, 24L, 11L, 26L, 27L, 28L, 11L,
                                                                                             28L, 46L, 47L, 25L, 27L, 11L, 26L, 11L, 49L, 24L, 49L, 26L, 11L,
                                                                                             51L, 39L, 51L, 51L, 49L, 26L, 51L, 49L, 39L, 54L, 26L, 11L, 16L,
                                                                                             25L, 41L, 48L, 49L, 55L, 55L, 41L, 48L, 55L, 48L, 27L, 57L, 11L,
                                                                                             58L, 55L, 48L, 57L, 48L, 58L, 59L, 48L, 58L, 60L, 59L, 57L, 55L,
                                                                                             55L, 58L, 59L, 48L, 57L, 41L, 61L, 60L, 59L, 48L, 62L, 57L, 58L,
                                                                                             61L, 60L, 55L, 55L, 62L, 48L, 63L, 58L, 61L, 60L, 59L, 57L, 11L,
                                                                                             63L, 64L, 48L, 62L, 58L, 61L, 60L, 59L, 57L, 55L, 64L, 58L, 59L,
                                                                                             62L, 65L, 48L, 63L, 61L, 60L, 57L, 25L, 11L, 24L, 27L, 48L, 41L,
                                                                                             25L, 68L, 11L, 24L, 27L, 48L, 41L, 25L, 69L, 68L, 11L, 24L, 27L,
                                                                                             41L, 58L, 27L, 69L, 68L, 70L, 11L, 48L, 41L, 25L, 26L, 27L, 11L,
                                                                                             48L, 48L, 73L, 69L, 68L, 25L, 48L, 41L, 70L, 71L, 64L, 65L, 66L,
                                                                                             63L, 62L, 48L, 58L)), .Names = c("from", "to"), class = "data.frame", row.names = c(NA,
                                                                                                                                                                                 254L))

  # Create barplot
  output$mynetwork <- renderVisNetwork({

    visNetwork(nodes, edges, height = "900px", width = "100%") %>%
      visOptions(selectedBy = "group",
                 highlightNearest = TRUE,
                 nodesIdSelection = TRUE) %>%
      visPhysics(stabilization = FALSE)
  })

} # end: tab_5_server()
