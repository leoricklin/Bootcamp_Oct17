library(dplyr)
library(tidyr)
library(googleVis)

rm(list=ls())

#qog_full <- read.csv("outputs/qog_homicide.csv", stringsAsFactors = FALSE)
qog_df <- read.csv("outputs/qog_homicide_filtered.csv", stringsAsFactors = FALSE)


## build filtered data set for most important covariates
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

#########
## PCA ##
#########


## Build covariate matrix
qog_mat <- qog_reduced %>% 
  select(country, infant_mortality, GDP_per_capita,education_male_15_24, education_male_55_64,
         household_consumption, urban_pop_percent,rural_sanitation_access, rural_water_access,
         telephone_subscriptions)  %>% 
  filter(!country %in% c("Liechtenstein", "Singapore", "San Marino", "Tuvalu"))

covariates <- c("infant_mortality", "GDP_per_capita","education_male_15_24", "education_male_55_64",
                "household_consumption", "urban_pop_percent","rural_sanitation_access", "rural_water_access",
                "telephone_subscriptions")   


## Impute missing data with median values for each country and covariate
for(x in covariates)  {
  for(country in unique(qog_mat$country)){
    med <- median(qog_mat[[x]][qog_mat$country == country], na.rm = TRUE)
    qog_mat[[x]][qog_mat$country == country][is.na(qog_mat[[x]][qog_mat$country == country])] <- med
  }
}

## check for missing values
summary(qog_mat)
any(is.na(qog_mat))

## do the pca
qog_pca <- prcomp(as.matrix(qog_mat %>% select(-country)), scale. = TRUE)

## build data frame
pca_df <- bind_rows(as.data.frame(qog_pca$rotation),
          data.frame(matrix(rep(NA, 9), nrow = 1, dimnames = list(NULL, colnames(qog_pca$rotation)))),
          as.data.frame(summary(qog_pca)$importance)) %>% 
  mutate(Variable = c(row.names(qog_pca$rotation), "",
                      row.names(summary(qog_pca)$importance))) %>% 
  select(Variable, PC1, PC2)

##################################
## Get correlation coefficients ##
##################################

##correlation with homicide
cor_homicide <- function(df, x, ...){
  cor(df[[x]], df$homicides, ...)
}


corrs <- sapply(covariates, function(v) cor_homicide(qog_reduced, v, method = "spearman", use = "complete.obs"))

corrs_df <- data_frame(Variable = names(corrs),
                       correlation = round(corrs, 3))



write.csv(qog_reduced, file = "outputs/qog_reduced.csv", row.names = FALSE)
write.csv(qog_reduced, file = "../Bootcamp_Oct17/dashboard/data/qog_reduced.csv", row.names = FALSE)
write.csv(pca_df, file = "../Bootcamp_Oct17/dashboard/data/pca_df.csv", row.names = FALSE)
write.csv(corrs_df, file = "../Bootcamp_Oct17/dashboard/data/corrs_df.csv", row.names = FALSE)






p <- gvisMotionChart(qog_reduced, 
                     idvar="country", 
                     colorvar = "continent",
                     timevar="year",
                     sizevar = "pop_size",
                     xvar = "infant_mortality",
                     yvar = "homicides")

plot(p)




