rm(list=c(ls()))

print(getwd())

# ---------------------------------------------
#  Load Packages 
# ---------------------------------------------
if(!require(shiny))          {install.packages('shiny', dependencies = TRUE);require(shiny)}
if(!require(shinydashboard)) {install.packages('shinydashboard', dependencies = TRUE);require(shinydashboard)}
if(!require(leaflet))       {install.packages('leaflet', dependencies = TRUE);require(leaflet)}
if(!require(stringr))        {install.packages('stringr', dependencies = TRUE);require(stringr)}
if(!require(dygraphs))        {install.packages('dygraphs', dependencies = TRUE);require(dygraphs)}
if(!require(visNetwork))        {install.packages('visNetwork', dependencies = TRUE);require(visNetwork)}

#Added packages
if(!require(DT))        {install.packages('DT', dependencies = TRUE);require(DT)}

# ---------------------------------------------
#  Load Modules
# ---------------------------------------------
my_modules <- list.files("tabs", pattern = "tab_module.R", full.names = TRUE,
                         recursive = TRUE)

for(my_module in my_modules) source(my_module)
