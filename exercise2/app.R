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
library(streamgraph)
library(lazyeval)
library(GGally)
library(ellipse)
library(RColorBrewer)
library(treemap)
library(plotly)
library(hrbrthemes)

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
    theme = shinytheme("flatly"),
    fluidRow(class = "main",
        div(class = "content-wrapper",
            header("Header"),
            content("Content")
        )
    ),
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
    tags$script(src = "script.js")
)

###################################################
##########           Server        ################
###################################################

server <- function(input, output, session) {

    # Save global session
    values$globalSession <- session

    # Call modules
    callModule(infant_mortality_server, "InfantMortality")
    callModule(co2_emissions_server, "CO2Emission")
    callModule(gdp_server, "GDP")
    callModule(population_server, "Population")
}

shinyApp(ui, server)
