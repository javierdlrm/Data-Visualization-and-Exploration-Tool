###################################################
##########      CO2 emissions Module       ########
###################################################

co2_emissions_path <- "CO2 emissions/"

# Data preprocessing

source(str_c(co2_emissions_path, "data-preprocessing.R"), local = TRUE)

# UI

co2_emissions_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "CO2 emissions",
        column(width = 2, class = "sidebar", box(width = 12, h4(class = "accent-color", "Options"),
            selectizeInput(ns('countries'), "Countries:", choices = countries, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a country name, e.g. Spain', maxItems = 28)),
            selectizeInput(ns('years'), "Years:", choices = years, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a year, e.g. 2001', maxItems = 15)))),
        column(width = 10, class = "content", box(width = 12,
            h4("CO2 emissions per country and year"),
            plotOutput(ns("plot.tile.co2_emission")))))
}

# Server

co2_emissions_server <- function(input, output, session) {

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

    # plots

    output$plot.tile.co2_emission <- renderPlot({
        req(values$europe_stats)

        years <- as.numeric(isolate(values$years_selected))
        print(years)
        print(unique(values$europe_stats()$year))
        ggplot(data = values$europe_stats(), aes(x = country.name, y = year)) +
            geom_tile(aes(fill = co2.emission.pc)) +
            geom_text(aes(label = round(co2.emission.pc, digits = 2)), colour = "lightgray") +
            labs(x = "Country", y = "CO2 Emission") +
            scale_x_discrete(expand = c(0, 0)) +
            scale_y_discrete(expand = c(0, 0), limits = years, drop = TRUE)
    })
}
