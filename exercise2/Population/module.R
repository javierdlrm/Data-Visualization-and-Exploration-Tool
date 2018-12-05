###################################################
##########         Population Module       ########
###################################################

population_path <- "Population/"

# Data preprocessing

source(str_c(population_path, "data-preprocessing.R"), local = TRUE)

# UI

population_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "Maps",
        column(width = 2, class = "sidebar", box(width = 12, h4(class = "accent-color", "Options"),
            selectizeInput(ns('countries'), "Countries:", choices = countries, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a country name, e.g. Spain', maxItems = 28)),
            selectizeInput(ns('years'), "Years:", choices = years, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a year, e.g. 2001', maxItems = 15)))),
        column(width = 10, class = "content", box(width = 12,
            h4("Huge map of Europe"))))
}

# Server

population_server <- function(input, output, session) {

    # countries

    observe({
        req(values$countries_selected)
        if (length(isolate(input$countries)) != length(values$countries_selected)) {
            updateSelectizeInput(session, 'countries', choices = isolate(values$countries), selected = values$countries_selected, server = TRUE)
        }
    })
    observe({
        req(input$countries)
        if (length(input$countries) != length(isolate(values$countries_selected))) {
            values$countries_selected <<- input$countries
        }
    })

    # years

    observe({
        req(values$years_selected)
        if (length(isolate(input$years)) != length(values$years_selected)) {
            updateSelectizeInput(session, 'years', choices = isolate(values$years), selected = values$years_selected, server = TRUE)
        }
    })
    observe({
        req(input$years)
        if (length(input$years) != length(isolate(values$years_selected))) {
            values$years_selected <<- input$years
        }
    })
}
