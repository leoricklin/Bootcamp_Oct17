library(dplyr)
library(tidyr)
library(stringr)
library(gapminder)

## call in data
qog <- read.csv("data/qog_std_ts_jan17.csv", stringsAsFactors = FALSE)
homicides <- read.csv("data/API_VC.IHR.PSRC.P5_DS2_en_csv_v2/API_VC.IHR.PSRC.P5_DS2_en_csv_v2.csv",
                  skip = 4, stringsAsFactors = FALSE)

## Fix homicides

homicides_long <- homicides %>% 
  group_by(Country.Name) %>% 
  gather(year, homicides, X1960:X2016) %>% 
  ungroup %>% 
  transmute(
    country = Country.Name,
    year = as.integer(str_replace_all(year, "^[A-Za-z]+", "")),
    homicides = homicides) %>% 
  arrange(country, year)


## Fix qog

qog_long <- qog %>% 
  select(-ccode, -ccodealp, -cname_year, -ccodealp_year, 
         -ccodecow, -ccodewb, -version) %>% 
  rename(country = cname) %>% 
  arrange(country, year)

## merge datasets
qog_homicide <- qog_long %>% 
  inner_join(homicides_long, by = c("country", "year"))


## Get continents data from Gapminder
continent_df <- gapminder %>% 
  group_by(country) %>% 
  summarise(continent = first(continent)) %>% 
  ungroup %>% 
  mutate(country = as.character(country),
         continent = as.character(continent)) %>% 
  filter(country %in% unique(qog_homicide$country))


qog_homicide_cont <- qog_homicide %>% 
  left_join(continent_df, by = "country")

missing_continents <- qog_homicide_cont %>% 
  filter(is.na(continent)) %>% 
  select(country, continent) %>% 
  distinct

write.csv(missing_continents, file = "data/missing_continents.csv", row.names = FALSE)


## Fix missing continents file manually! ##

missing_continents <- read.csv("data/missing_continents_manualfix.csv", stringsAsFactors = FALSE)

## insert new continents into missing data points:
for(i in 1:nrow(missing_continents)){
  qog_homicide_cont$continent[qog_homicide_cont$country == missing_continents$country[i]] <- 
    missing_continents$continent[i]
}


## Filter to only include rows containing homicide data:
qog_df <- qog_homicide_cont %>% 
  filter(!is.na(homicides))

## gives the proportion of the columns that contain data
data_rates <- apply(qog_df, 2, function(x) mean(!is.na(x)))


## for test data, retain only the columns with a proportion of
## complete data >= p
p <- 0.95
qog_df <- qog_df[,names(qog_df)[data_rates >= p]]


## Keep only countries where there is at least 10 years of data
qog_df <- qog_df %>% 
  group_by(country) %>% 
  mutate(count = n()) %>% 
  filter(count >= 10) %>% 
  select(-count)


write.csv(qog_homicide_cont, file = "outputs/qog_homicide.csv", row.names = FALSE)
write.csv(qog_df, file = "outputs/qog_homicide_filtered.csv", row.names = FALSE)



