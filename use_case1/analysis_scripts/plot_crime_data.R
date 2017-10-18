library(dplyr)
library(tidyr)
library(googleVis)

rm(list=ls())

qog_full <- read.csv("outputs/qog_homicide.csv", stringsAsFactors = FALSE)
qog_df <- read.csv("outputs/qog_homicide_filtered.csv", stringsAsFactors = FALSE)


qog_reduced <- qog_df %>% 
  select(country, continent, year, homicides, unna_pop, wdi_mortinf, unna_gdp,
         wdi_lrmd, wdi_popurb, wdi_acis)
p <- gvisMotionChart(qog_reduced, 
                     idvar="country", 
                     colorvar = "continent",
                     timevar="year",
                     sizevar = "unna_pop",
                     xvar = "wdi_mortinf",
                     yvar = "homicides")

plot(p)







