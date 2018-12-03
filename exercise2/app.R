###################################################
##########           Libraries     ################
###################################################

library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinythemes)
library(stringr)
library(gdata)
library(readxl)
library(sqldf)
library(dplyr)
library(ggplot2)
library(maps)
library(mapproj)
library(tidyr)
library(leaflet)
library(reshape2)
library(directlabels)

###################################################
##########           Sources       ################
###################################################

source("layout.R")
source("global.R")
source("helpers.R")

###################################################
##########           UI            ################
###################################################

ui <- fluidPage(
    shinyjs::useShinyjs(debug = TRUE),
    theme = shinytheme("cosmo"),
    fluidRow(class = "main",
        div(class = "content-wrapper",
            header("Header"),
            content("Content")
        )
    ),
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"))
)

###################################################
##########           Server        ################
###################################################

server <- function(input, output, session) {

    # Save global session
    values$globalSession <- session

    # Call modules
    #callModule(population_server, "Population")
    callModule(pollution_server, "Pollution")
    #callModule(infant_mortality_server, "InfantMortality")
    #callModule(europe_stat_server, "EuropeStat")
    #callModule(exploration_server, "Exploration")
}

shinyApp(ui, server)
