library(dplyr)
library(tidyr)
library(googleVis)

rm(list=ls())

#qog_full <- read.csv("outputs/qog_homicide.csv", stringsAsFactors = FALSE)
qog_df <- read.csv("outputs/qog_homicide_filtered.csv", stringsAsFactors = FALSE)


qog_reduced <- qog_df %>% 
  select(country, continent, year, homicides, unna_pop, wdi_mortinf, unna_gdppc,
         wdi_popurb, wdi_acisr, wdi_aciwr, unna_hce,
         gea_ea1524m, gea_ea5564m, wdi_tele) %>%
   rename(pop_size = unna_pop,
         infant_mortality = wdi_mortinf,
         GDP_per_capita = unna_gdppc,
         education_male_15_24 = gea_ea1524m,
         education_male_55_64 = gea_ea5564m,
         household_consumption = unna_hce,
         urban_pop_percent = wdi_popurb,
         rural_sanitation_access = wdi_acisr,
         rural_water_access = wdi_aciwr,
         telephone_subscriptions = wdi_tele)
  
write.csv(qog_reduced, file = "outputs/qog_reduced.csv", row.names = FALSE)
write.csv(qog_reduced, file = "../Bootcamp_Oct17/dashboard/data/qog_reduced.csv", row.names = FALSE)


p <- gvisMotionChart(qog_reduced, 
                     idvar="country", 
                     colorvar = "continent",
                     timevar="year",
                     sizevar = "pop_size",
                     xvar = "infant_mortality",
                     yvar = "homicides")

plot(p)







