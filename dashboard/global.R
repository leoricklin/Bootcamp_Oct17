rm(list=c(ls()))

print(getwd())

# ---------------------------------------------
#  Load Packages 
# ---------------------------------------------
if(!require(shiny))          {install.packages('shiny', dependencies = TRUE);require(shiny)}
if(!require(shinydashboard)) {install.packages('shinydashboard', dependencies = TRUE);require(shinydashboard)}
if(!require(reshape2))       {install.packages('reshape2', dependencies = TRUE);require(reshape2)}
if(!require(ggplot2))        {install.packages('ggplot2', dependencies = TRUE);require(ggplot2)}


# ---------------------------------------------
#  Load Modules
# ---------------------------------------------
my_modules <- list.files("tabs", pattern = "tab_module.R", full.names = TRUE,
                         recursive = TRUE)

for(my_module in my_modules) source(my_module)
