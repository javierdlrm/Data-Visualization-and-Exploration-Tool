###################################################
##########           Layout        ################
###################################################

source("Infant mortality/module.R")
source("CO2 emissions/module.R")
source("GDP/module.R")
source("Population/module.R")
source("Clustering/module.R")

# Header

header <- function(id) {
    ns <- NS(id)
    div(h1("Exploratory tool", class = "title"))
}

# Content

content <- function(id) {
    ns <- NS(id)
    tabsetPanel(id = "tabs", infant_mortality_ui("InfantMortality"), co2_emissions_ui("CO2Emission"), gdp_ui("GDP"), population_ui("Population"), clustering_ui("Clustering"), type = "pills")
}