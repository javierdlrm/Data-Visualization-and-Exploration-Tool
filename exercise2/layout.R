###################################################
##########           Layout        ################
###################################################

source("Population/module.R")
source("CO2 emissions/module.R")
source("Infant mortality/module.R")
source("Europe stats/module.R")
source("Exploration/module.R")

# Header

header <- function(id) {
    ns <- NS(id)
    div(
        h1("Exploratory analysis", class = "title")
    )
}

# Content

content <- function(id) {
    ns <- NS(id)
    tabsetPanel(id = "tabs", population_ui("Population"), co2_emissions_ui("Pollution"), infant_mortality_ui("InfantMortality"), europe_stats_ui("EuropeStat"), exploration_ui("Exploration"), type = "pills")
}