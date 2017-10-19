library(dplyr)
library(tidyr)
library(googleVis)

rm(list=ls())

#qog_full <- read.csv("outputs/qog_homicide.csv", stringsAsFactors = FALSE)
qog_df <- read.csv("outputs/qog_homicide_filtered.csv", stringsAsFactors = FALSE)


qog_reduced <- qog_df %>% 
  select(country, continent, year, homicides, unna_pop, wdi_mortinf, unna_gdp,
         wdi_lrmd, wdi_popurb, wdi_acis) %>%
   rename(pop_size = unna_pop,
         infant_mortality = wdi_mortinf,
         GDP = unna_gdp,
         maternal_death_risk = wdi_lrmd,
         urban_pop_percent = wdi_popurb,
         access_sanitation_percent = wdi_acis) %>% 
  mutate(GDP_per_capita = GDP / pop_size)

write.csv(qog_reduced, file = "outputs/qog_reduced.csv", row.names = FALSE)

p <- gvisMotionChart(qog_reduced, 
                     idvar="country", 
                     colorvar = "continent",
                     timevar="year",
                     sizevar = "pop_size",
                     xvar = "infant_mortality",
                     yvar = "homicides")

plot(p)







